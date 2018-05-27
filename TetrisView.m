#import "TetrisView.h"
#import "FallingBlocksViewController.h"


CGColorRef NewColor(CGColorSpaceRef colorSpace, float r, float g, float b, float alpha);

@implementation TetrisView

@synthesize board;
@synthesize appDelegate;


- (instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	
	return self;
}


- (void)layoutSubviews
{
	//[self startNewGameWithBoardSize:NSMakeSize(10, 20)];
}

- (void)startNewGameWithBoardWidth:(int)width height:(int)height
{
	board=[[Board alloc] initWithWidth:width height:height];
	
	updateTimer=[NSTimer scheduledTimerWithTimeInterval:((double)[board getTimeBetweenUpdates])/1000 target:self selector:@selector(updateFromTimer:) userInfo:nil repeats:YES];
	
	blockWidth=self.frame.size.width / board.width;
	blockHeight=self.frame.size.height / board.height;
}

- (void)updateFromTimer:(NSTimer *)timer
{
	[updateTimer invalidate];
	
	[board update];
	
	// Update the timer
	updateTimer=[NSTimer scheduledTimerWithTimeInterval:((double)[board getTimeBetweenUpdates])/1000 target:self selector:@selector(updateFromTimer:) userInfo:nil repeats:YES];
	
	[((FallingBlocksViewController *)appDelegate) updateNextBlock:board.nextBlockType];
	
	[self setNeedsDisplay];
	
	if (board.gameOver) {
		[((FallingBlocksViewController *)appDelegate) setGameOver];
	}
}

- (IBAction)fastDown {
    [board.block moveDown];
}

- (IBAction)moveLeft {
    [board.block moveLeft];
}

- (IBAction)moveRight {
    [board.block moveRight];
}

- (IBAction)rotate {
    [board.block rotate];
}


- (void)drawGradientBox:(CGContextRef)context colorSpace:(CGColorSpaceRef)colorSpace rect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor
{
	CGColorRef gradColors[2] = {startColor, endColor};
	
	CGGradientRef grad=CGGradientCreateWithColors(colorSpace, CFArrayCreate(NULL, (void *)gradColors, 2, &kCFTypeArrayCallBacks), NULL);
	CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width, rect.size.height), CGPointMake(0, 0), 0);
	
	CGGradientRelease(grad);
}


- (void)drawBlock:(CGContextRef)context X:(int)x Y:(int)y red:(float)r green:(float)g blue:(float)b
{
	int xPos=x*blockWidth;
	int yPos=y*blockHeight;
	
	CGRect innerBlockRect=CGRectMake(xPos+1, yPos+1, blockWidth - 2, blockHeight - 2);
	CGRect outerBlockRect=CGRectMake(xPos, yPos, blockWidth, blockHeight);
	
	CGFloat innerColorParts[]={ r, g, b, 1 };
	CGFloat outerColorParts[]={ 0.1, 0.1, 0.1, 1 };
	
	CGContextSetFillColor(context, outerColorParts);
	CGContextFillRect(context, outerBlockRect);
	
	CGContextSetFillColor(context, innerColorParts);
	CGContextFillRect(context, innerBlockRect);
}


- (void)drawRect:(CGRect)rect
{	
	CGContextRef context=UIGraphicsGetCurrentContext();
	
	CGContextFillRect(context, rect);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	[self drawGradientBox:context colorSpace:colorSpace rect:rect startColor:NewColor(colorSpace, 0.9, 0.3, 0.45, 1) endColor:NewColor(colorSpace, 0.3, 0.2, 0.9, 1)];
	
	if (!board.gameOver) {
		int i;
		for (i=0;i<board.height;i++) {
			int j;
			for (j=0; j<board.width; j++) {
				BoardCell *cell=[board.cells getCellAtX:j Y:i];
				
				if (cell.cellState==CellStateEmpty) {
					// Draw an empty block?
				} else {
					[self drawBlock:context X:j Y:i red:cell.red green:cell.green blue:cell.blue];
				}
			}
		}
		
		//CGContextMoveToPoint(context, 0, 0);
		//CGContextAddLineToPoint(context, 100, 100);
		
		CGContextSetFontSize(context, 1);
		CGContextSetRGBFillColor(context, 0, 0, 0, 1);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		char levelText[32];
		sprintf(levelText, "Level: %d", board.level);
		//CGContextShowTextAtPoint(context, 40, 50, "Quartz 2D", 9);
	} else { // Game over
		CGContextSetFontSize(context, 8);
		CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 1);
		CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);
		CGContextShowTextAtPoint(context, 40, 50, "Game Over!", 9);
	}
	
	CGContextStrokePath(context);
}


- (IBAction)endGame {
	[updateTimer invalidate];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	int thirdOfWidth=self.frame.size.width/3;
	
	if (point.x > (self.frame.size.width-thirdOfWidth))
		[self moveRight];
	else if (point.x < thirdOfWidth)
		[self moveLeft];
	else if (point.y > self.frame.size.height-125)
		[self fastDown];
	else
		[self rotate];
	
	[self setNeedsDisplay];
	
	return point.y > 20;
}

@end

CGColorRef NewColor(CGColorSpaceRef colorSpace, float r, float g, float b, float alpha)
{
	CGFloat components[4] = {r, g, b, alpha};
	CGColorRef col=CGColorCreate(colorSpace, components);
	
	return col;
}
