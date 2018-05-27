#define CELL_SIZE	40

//
//  MSMinesweeperView.m
//  Touchtris
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MSMinesweeperView.h"
#import "UIScrollView+Helper.h"
#import "UIView+Helper.h"

CGColorRef MSVNewColor(CGColorSpaceRef colorSpace, CGFloat r, CGFloat g, CGFloat b, CGFloat alpha);

@interface MSMinesweeperView()
{
	UITapGestureRecognizer *_tapGestureRecognizer;
	UILongPressGestureRecognizer *_longPressGestureRecognizer;
}

@property (nonatomic, readonly, getter=parentScrollView) UIScrollView *parentScrollView;

@end

@implementation MSMinesweeperView

@synthesize infoLabel;
@synthesize timeLabel;

+ (Class)layerClass
{
	return [CATiledLayer class];
}

- (instancetype)init
{
    if (self = [super init]) {
		CATiledLayer *tiledLayer = (CATiledLayer *)self.layer;
		
		tiledLayer.levelsOfDetail = 1;
		tiledLayer.tileSize = CGSizeMake(CELL_SIZE * 16, CELL_SIZE * 16);
		
        gameTimeTimer = nil;
		board = nil;
		
		_tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		
		[self addGestureRecognizer:_tapGestureRecognizer];
		
		_longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
		
		[self addGestureRecognizer:_longPressGestureRecognizer];
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer
{
	[self touched:recognizer markerMode:NO];
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan)
		[self touched:recognizer markerMode:YES];
}

- (void)touched:(UIGestureRecognizer *)recognizer markerMode:(BOOL)markerMode
{
	CGPoint point = [recognizer locationOfTouch:0 inView:self];
	
	if (point.x < 0) return;
	
	float ySeg = self.bounds.size.height / board.rowCount;
	float xSeg = self.bounds.size.width / board.columnCount;
	
	int x, y;
	
	for (x = 0; x < board.columnCount; x++) {
		if (x * xSeg < point.x && (x+1)*xSeg > point.x)
			break;
	}
	
	for (y = 0; y < board.rowCount; y++) {
		if (y*ySeg < point.y && (y+1)*ySeg > point.y)
			break;
	}
	
	// TODO Figure out why this hack is needed
	if (x >= board.columnCount || y >= board.rowCount) return;
	NSLog(@"%d, %d", x, y);
	
	if (markerMode) {
		[board addMarkerAtX:x Y:y];
	} else
		[board activateCellAtX:x Y:y];
	
	[self setInfoLabel];
	
	[self setNeedsDisplay];
}

- (void)setInfoLabel
{
	if (board.won) {
		infoLabel.text = [NSString stringWithFormat:@"All %d mines found!", board.mines];
		if (gameTimeTimer !=nil) {
			[gameTimeTimer invalidate];
			gameTimeTimer=nil;
		}
		
		[UIView animateWithDuration:0.35 delay:0 options:0 animations:^{
			[UIView setAnimationRepeatCount:2];
			
			self.parentScrollView.superview.transform = CGAffineTransformMakeRotation(M_PI);
		} completion:^(BOOL finished) {
			self.parentScrollView.superview.transform = CGAffineTransformIdentity;
		}];
	} else if (board.gameOver) {
		infoLabel.text = @"Game Over! Mine hit!";
		if (gameTimeTimer != nil) {
			[gameTimeTimer invalidate];
			gameTimeTimer = nil;
		}
		
		[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
			[UIView setAnimationRepeatCount:6];
			
			self.parentScrollView.transform = CGAffineTransformMakeScale(1.2, 1.2);
		} completion:^(BOOL finished) {
			self.parentScrollView.transform = CGAffineTransformIdentity;
		}];
	} else
		infoLabel.text = [NSString stringWithFormat:@"Mines: %d, Markers: %d", board.mines, board.markers];
}

- (UIScrollView *)parentScrollView
{
	return (UIScrollView *)self.superview;
}

- (void)newGameWithRows:(int)rows columns:(int)columns difficulty:(float)difficulty
{
	self.frame = CGRectMake(0, 0, columns * CELL_SIZE, rows * CELL_SIZE);
	
	self.parentScrollView.contentSize = self.frame.size;
	[self.parentScrollView centerOnPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) animated:NO];
	
	if (gameTimeTimer) {
		[gameTimeTimer invalidate];
		gameTimeTimer=nil;
	}
	
	timeLabel.text=@"";
	
	secondsSinceStart=0;
	
	board=[[MSBoard alloc] initWithRows:rows columns:columns difficulty:difficulty];
	
	gameTimeTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondsIncrementTick:) userInfo:nil repeats:YES];
	
	[self setInfoLabel];
	
	[self setNeedsDisplay];
}

- (void)secondsIncrementTick:(NSTimer *)timer
{
	secondsSinceStart++;
	
	timeLabel.text=[NSString stringWithFormat:@"%d", secondsSinceStart];
}

- (void)drawNumberAtX:(float)x Y:(float)y width:(float)w height:(float)h context:(CGContextRef)context number:(int)num
{
	char text[2];
	sprintf(text, "%d", num);
    CGContextSelectFont(context, "Helvetica", h-4, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0.5, 0.2, 0.2, 1);
    
	CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    CGContextSetTextMatrix(context, xform);
	
    CGContextShowTextAtPoint(context, x+(w*0.2), y+h-7, text, strlen(text));
}

- (void)drawMarkerAtX:(float)x Y:(float)y width:(float)w height:(float)h context:(CGContextRef)context
{
	CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.45, 0.45, 0.45, 1));
	CGContextFillRect(context, CGRectMake(x+2, y+2, w-4, h-4));
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.65, 1, 0.6, 1));
	CGContextFillRect(context, CGRectMake(x+6, y+6, w-12, h-12));
	
	CGColorSpaceRelease(colorSpace);
}

- (void)drawUnknownAtX:(float)x Y:(float)y width:(float)w height:(float)h context:(CGContextRef)context
{
	CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.45, 0.45, 0.45, 1));
	CGContextFillRect(context, CGRectMake(x+2, y+2, w-4, h-4));
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.65, 0.65, 0.6, 1));
	CGContextFillRect(context, CGRectMake(x+6, y+6, w-12, h-12));
	
	CGColorSpaceRelease(colorSpace);
}

- (void)drawMineAtX:(float)x Y:(float)y width:(float)w height:(float)h context:(CGContextRef)context
{
	CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.25, 0.25, 0.35, 1));
	CGContextFillEllipseInRect(context, CGRectMake(x+2, y+2, w-4, h-4));
	
	CGContextSetFillColorWithColor(context, MSVNewColor(CGColorSpaceCreateDeviceRGB(), 0.3, 0.3, 0.45, 1));
	CGContextFillEllipseInRect(context, CGRectMake(x+6, y+6, w-12, h-12));
	
	CGContextSetLineWidth(context, 4);
	
	CGContextMoveToPoint(context, x+2, y+2);
	CGContextAddLineToPoint(context, x+w-2, y+h-2);
	
	CGContextMoveToPoint(context, x+w-2, y+2);
	CGContextAddLineToPoint(context, x+2, y+h-2);
	
	CGContextStrokePath(context);
	
	CGColorSpaceRelease(colorSpace);
}

- (void)drawRect:(CGRect)drawRect
{
	if (!board) return;
	
	CGRect rect = CGRectMake(0, 0, board.columnCount * CELL_SIZE, board.columnCount * CELL_SIZE);
	
	float ySeg=rect.size.height/board.rowCount;
	float xSeg=rect.size.width/board.columnCount;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	NSLog(@"%f, %f", xSeg, ySeg);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextSetFillColorWithColor(context, MSVNewColor(colorSpace, 1, 1, 1, 1));
	CGContextFillRect(context, rect);
	
	int xStart = CGRectGetMinX(drawRect) / CELL_SIZE;
	int yStart = CGRectGetMinY(drawRect) / CELL_SIZE;
	
	int xEnd = CGRectGetMaxX(drawRect) / CELL_SIZE;
	if (xEnd > board.columnCount) xEnd = board.columnCount;
	int yEnd = CGRectGetMaxY(drawRect) / CELL_SIZE;
	if (yEnd > board.rowCount) yEnd = board.rowCount;
	
	{ // Draw the board outline
		CGContextSetFillColorWithColor(context, MSVNewColor(colorSpace, 0.5, 0.5, 0.75, 1));
		
		CGContextSetLineWidth(context, 1);
		
		// Inside crossing lines
		for (int x=0; x<board.rowCount; x++) {
			CGContextMoveToPoint(context, xSeg*x, 0);
			CGContextAddLineToPoint(context, xSeg*x, rect.size.height);
		}
		
		for (int y=0; y<board.columnCount; y++) {
			CGContextMoveToPoint(context, 0, ySeg*y);
			CGContextAddLineToPoint(context, rect.size.width, ySeg*y);
		}
		
		// Outer lines
		CGContextMoveToPoint(context, 0, 0);
		CGContextAddLineToPoint(context, rect.size.width, 0);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextAddLineToPoint(context, 0, rect.size.height);
		CGContextAddLineToPoint(context, 0, 0);
		
		CGContextStrokePath(context);
		
		// Draw board items
		for (int y = yStart; y < yEnd; y++) {
			for (int x = xStart; x < xEnd; x++) {
				MSCell *cell=[board cellAtX:x Y:y];
				
				if (cell.hasMarker)
					[self drawMarkerAtX:x*xSeg Y:y*ySeg width:xSeg height:ySeg context:context];
				else if (cell.isHidden)
					[self drawUnknownAtX:x*xSeg Y:y*ySeg width:xSeg height:ySeg context:context];
				else if (cell.hasMine)
					[self drawMineAtX:x*xSeg Y:y*ySeg width:xSeg height:ySeg context:context];
				else if (cell.surroundingMines>0)
					[self drawNumberAtX:x*xSeg Y:y*ySeg width:xSeg height:ySeg context:context number:cell.surroundingMines];
			}
		}
	}
}

- (void)dealloc {
	
	if (gameTimeTimer !=nil) {
		[gameTimeTimer invalidate];
	}
	
}

@end

CGColorRef MSVNewColor(CGColorSpaceRef colorSpace, CGFloat r, CGFloat g, CGFloat b, CGFloat alpha)
{
	CGFloat components[4] = {r, g, b, alpha};
	CGColorRef col=CGColorCreate(colorSpace, components);
	
	return col;
}
