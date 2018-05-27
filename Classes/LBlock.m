//
//  LBlock.m
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LBlock.h"

#import "Board.h"


@implementation LBlock

- (instancetype)initWithBoard:(id)board
{
	if (!(self = [super initWithBoard:board])) return nil;
	
	rotation=0;
	
	return self;
}


- (void)build
{
	Board *b=[self board];
	
	cells[0]=[self createBlockCellAtX:b.width/2-1 Y:0];
	cells[1]=[self createBlockCellAtX:b.width/2-1 Y:1];
	cells[2]=[self createBlockCellAtX:b.width/2-1 Y:2];
	cells[3]=[self createBlockCellAtX:b.width/2 Y:2];
}


- (void)rotate
{
	switch (rotation) {
		case 0:
			if ([self isCellMoveLegalAt:0 XOffset:1 YOffset:1] &&
				[self isCellMoveLegalAt:2 XOffset:-1 YOffset:-1] &&
				[self isCellMoveLegalAt:3 XOffset:-2 YOffset:0]) {
				[self moveCellAt:0 XOffset:1 YOffset:1];
				[self moveCellAt:2 XOffset:-1 YOffset:-1];
				[self moveCellAt:3 XOffset:-2 YOffset:0];
				
				rotation=1;
			}
			
			break;
		case 1:
			if ([self isCellMoveLegalAt:0 XOffset:-1 YOffset:1] &&
				[self isCellMoveLegalAt:2 XOffset:1 YOffset:-1] &&
				[self isCellMoveLegalAt:3 XOffset:0 YOffset:-2]) {
				[self moveCellAt:0 XOffset:-1 YOffset:1];
				[self moveCellAt:2 XOffset:1 YOffset:-1];
				[self moveCellAt:3 XOffset:0 YOffset:-2];
				
				rotation=2;
			}
			
			break;
		case 2:
			if ([self isCellMoveLegalAt:0 XOffset:-1 YOffset:-1] &&
				[self isCellMoveLegalAt:2 XOffset:1 YOffset:1] &&
				[self isCellMoveLegalAt:3 XOffset:2 YOffset:0]) {
				[self moveCellAt:0 XOffset:-1 YOffset:-1];
				[self moveCellAt:2 XOffset:1 YOffset:1];
				[self moveCellAt:3 XOffset:2 YOffset:0];
				
				rotation=3;
			}
			
			break;
		case 3:
			if ([self isCellMoveLegalAt:0 XOffset:1 YOffset:-1] &&
				[self isCellMoveLegalAt:2 XOffset:-1 YOffset:1] &&
				[self isCellMoveLegalAt:3 XOffset:0 YOffset:2]) {
				[self moveCellAt:0 XOffset:1 YOffset:-1];
				[self moveCellAt:2 XOffset:-1 YOffset:1];
				[self moveCellAt:3 XOffset:0 YOffset:2];
				
				rotation=0;
			}
			
			break;
	}	
}

@end
