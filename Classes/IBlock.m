//
//  IBlock.m
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "IBlock.h"

@implementation IBlock

- (instancetype)initWithBoard:(id)board
{
	if (!(self = [super initWithBoard:board])) return nil;
	
	horizontal=YES;
	
	return self;
}

- (void)build
{
	Board *b=(Board *)[self board];
	
	cells[0]=[self createBlockCellAtX:b.width/2 - 2 Y:0];
	cells[1]=[self createBlockCellAtX:b.width/2 - 1 Y:0];
	cells[2]=[self createBlockCellAtX:b.width/2 Y:0];
	cells[3]=[self createBlockCellAtX:b.width/2 + 1 Y:0];
}

- (void)rotate
{
	if (horizontal) {
		if ([self isCellMoveLegalAt:0 XOffset:1 YOffset:-1] &&
			[self isCellMoveLegalAt:2 XOffset:-1 YOffset:1] &&
			[self isCellMoveLegalAt:3 XOffset:-2 YOffset:2]) {
			
			[self moveCellAt:0 XOffset:1 YOffset:-1];
			[self moveCellAt:2 XOffset:-1 YOffset:1];
			[self moveCellAt:3 XOffset:-2 YOffset:2];
			
			horizontal=NO;
		}
	} else {
		if ([self isCellMoveLegalAt:0 XOffset:-1 YOffset:1] &&
			[self isCellMoveLegalAt:2 XOffset:1 YOffset:-1] &&
			[self isCellMoveLegalAt:3 XOffset:2 YOffset:-2]) {
			
			[self moveCellAt:0 XOffset:-1 YOffset:1];
			[self moveCellAt:2 XOffset:1 YOffset:-1];
			[self moveCellAt:3 XOffset:2 YOffset:-2];
			
			horizontal=YES;
		}
	}
}

@end
