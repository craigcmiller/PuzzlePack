//
//  ReverseZBlock.m
//  MiniTetris
//
//  Created by Craig Miller on 13/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ReverseZBlock.h"

#import "Board.h"

@implementation ReverseZBlock

- (instancetype)initWithBoard:(id)board
{
	if (!(self = [super initWithBoard:board])) return nil;
	
	horizontal=YES;
	
	return self;
}

- (void)build
{
	Board *b=(Board *)[self board];
	
	cells[0]=[self createBlockCellAtX:b.width/2 Y:0];
	cells[1]=[self createBlockCellAtX:b.width/2+1 Y:0];
	cells[2]=[self createBlockCellAtX:b.width/2-1 Y:1];
	cells[3]=[self createBlockCellAtX:b.width/2 Y:1];
}

- (void)rotate
{
	if (horizontal) {
		if ([self isCellMoveLegalAt:2 XOffset:2 YOffset:0] &&
			[self isCellMoveLegalAt:1 XOffset:0 YOffset:2]) {
			
			[self moveCellAt:2 XOffset:2 YOffset:0];
			[self moveCellAt:1 XOffset:0 YOffset:2];
			
			horizontal=NO;
		}
	} else {
		if ([self isCellMoveLegalAt:2 XOffset:-2 YOffset:0] &&
			[self isCellMoveLegalAt:1 XOffset:0 YOffset:-2]) {
			
			[self moveCellAt:2 XOffset:-2 YOffset:0];
			[self moveCellAt:1 XOffset:0 YOffset:-2];
			
			horizontal=YES;
		}
	}
}


@end
