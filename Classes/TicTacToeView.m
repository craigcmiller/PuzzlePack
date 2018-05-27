//
//  TicTacToeView.m
//  Touchtris
//
//  Created by Craig Miller on 29/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TicTacToeView.h"



CGColorRef TTVNewColor(CGColorSpaceRef colorSpace, float r, float g, float b, float alpha);


@implementation TicTacToeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		board=[[TicTacToe alloc] init];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		board=[[TicTacToe alloc] init];
	}
	return self;
}


- (void)newGame:(NSInteger)side textField:(UILabel *)statusTextField
{
	NSLog(@"Start game with side: %d", (int32_t)side);
	statusField=statusTextField;
	
	[board newGame:side];
	
	[self setNeedsDisplay];
	statusField.text=@"Begin";
}


- (void)drawGradientBox:(CGContextRef)context colorSpace:(CGColorSpaceRef)colorSpace rect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor
{
	CGColorRef gradColors[2] = {startColor, endColor};
	
	CGGradientRef grad=CGGradientCreateWithColors(colorSpace, CFArrayCreate(NULL, (void *)gradColors, 2, &kCFTypeArrayCallBacks), NULL);
	CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width, rect.size.height), CGPointMake(0, 0), 0);
	
	CGGradientRelease(grad);
}


- (void)drawImage:(NSString *)name context:(CGContextRef)context X:(float)x Y:(float)y
{
	NSString *imageFileName=[[NSBundle mainBundle] pathForResource:name ofType:@"png"];
	CGDataProviderRef provider=CGDataProviderCreateWithFilename([imageFileName UTF8String]);
	CGImageRef notImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
	CGContextDrawImage(context, CGRectMake(x, y, 80, 80), notImage);
	CGImageRelease(notImage);
	CGDataProviderRelease(provider);
}


- (void)drawRect:(CGRect)rect
{
	float ySeg=rect.size.height/3;
	float xSeg=rect.size.width/3;
	CGContextRef context=UIGraphicsGetCurrentContext();
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextSetFillColorWithColor(context, TTVNewColor(colorSpace, 1, 1, 1, 1));
	CGContextFillRect(context, rect);
	
	//[self drawGradientBox:context colorSpace:colorSpace rect:rect startColor:TTVNewColor(colorSpace, 0.3, 0.9, 0.65, 1) endColor:TTVNewColor(colorSpace, 0.9, 0.5, 0.2, 1)];
	{ // Draw the board outline
		CGContextSetFillColorWithColor(context, TTVNewColor(colorSpace, 0.5, 0.5, 0.75, 1));
		
		// Inside crossing lines
		CGContextMoveToPoint(context, xSeg, 0);
		CGContextAddLineToPoint(context, xSeg, rect.size.height);
		
		CGContextMoveToPoint(context, xSeg*2, 0);
		CGContextAddLineToPoint(context, xSeg*2, rect.size.height);
		
		CGContextMoveToPoint(context, 0, ySeg);
		CGContextAddLineToPoint(context, rect.size.width, ySeg);
		
		CGContextMoveToPoint(context, 0, ySeg*2);
		CGContextAddLineToPoint(context, rect.size.width, ySeg*2);
		
		// Outer lines
		CGContextMoveToPoint(context, 0, 0);
		CGContextAddLineToPoint(context, rect.size.width, 0);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextAddLineToPoint(context, 0, rect.size.height);
		CGContextAddLineToPoint(context, 0, 0);
	}
	
	{ // Draw images for 0s and Xs
		int i;
		NSInteger *boardVals=[board getCurrentBoard];
		for (i=0; i<9; i++) {
			NSString *imageName;
			
			//switch (*(boardVals++)) {
			switch (boardVals[i]) {
				case CROSS:
					imageName=@"Cross";
					break;
				case CIRCLE:
					imageName=@"Not";
					break;
				default:
					continue;
			}
			
			float x, y;
			if (i>=3 && i<6)
				y=ySeg;
			else if (i>=6)
				y=ySeg*2;
			else y=0;
			
			x=(i % 3) * xSeg;
			
			[self drawImage:imageName context:context X:x+12 Y:y+12];
		}
	}
	
	CGContextStrokePath(context);
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	float ySeg=self.bounds.size.height/3;
	float xSeg=self.bounds.size.width/3;
	int x, y, move;
	
	if (point.y < ySeg) y=1;
	else if (point.y < ySeg*2) y=2;
	else y=3;
	
	if (point.x < xSeg) x=1;
	else if (point.x < xSeg*2) x=2;
	else x=3;
	
	NSLog(@"%f, %f (%f, %f) ---- %d, %d", point.x, point.y, xSeg, ySeg, x, y);
	move=(y-1)*3+(x-1);
	NSLog(@"Move: %d", move);
	
	[board addMove:move];
	
	[board compMove];
	
	if ([board moveNumber] < 9)
		statusField.text=[NSString stringWithFormat:@"Moves made: %d", (int32_t)[board moveNumber]];
	else statusField.text=@"No winner!";
	
	if ([board won])
		statusField.text=[NSString stringWithFormat:@"Winner: %@", ([board winner]==CROSS ? @"Crosses" : @"Circles")];
	
	[board drawBoardToSO];
	
	[self setNeedsDisplay];
	
	return YES;
}




@end

CGColorRef TTVNewColor(CGColorSpaceRef colorSpace, float r, float g, float b, float alpha)
{
	CGFloat components[4] = {r, g, b, alpha};
	CGColorRef col=CGColorCreate(colorSpace, components);
	
	return col;
}
