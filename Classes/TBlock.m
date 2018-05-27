//
//  TBlock.m
//  MiniTetris
//
//  Created by Craig Miller on 13/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TBlock.h"

#import "Board.h"


@implementation TBlock

- (instancetype)initWithBoard:(id)board
{
	if (!(self = [super initWithBoard:board])) return nil;
	
	rotation=0;
	
	return self;
}


- (void)build
{
	Board *b=[self board];
	
	cells[0]=[self createBlockCellAtX:b.width/2 Y:0];
	cells[1]=[self createBlockCellAtX:b.width/2-1 Y:1];
	cells[2]=[self createBlockCellAtX:b.width/2 Y:1];
	cells[3]=[self createBlockCellAtX:b.width/2+1 Y:1];
}


- (void)rotate
{
	switch (rotation) {
		case 0:
			if ([self isCellMoveLegalAt:1 XOffset:1 YOffset:1]) {
				[self moveCellAt:1 XOffset:1 YOffset:1];
				
				rotation=1;
			}
			
			break;
		case 1:
			if ([self isCellMoveLegalAt:0 XOffset:-1 YOffset:1]) {
				[self moveCellAt:0 XOffset:-1 YOffset:1];
				
				rotation=2;
			}
			
			break;
		case 2:
			if ([self isCellMoveLegalAt:3 XOffset:-1 YOffset:-1]) {
				[self moveCellAt:3 XOffset:-1 YOffset:-1];
				
				rotation=3;
			}
			
			break;
		case 3:
			if ([self isCellMoveLegalAt:3 XOffset:1 YOffset:1]) {
				[self moveCellAt:3 XOffset:1 YOffset:1];
				[self moveCellAt:0 XOffset:1 YOffset:-1];
				[self moveCellAt:1 XOffset:-1 YOffset:-1];
				
				rotation=0;
			}
			
			break;
	}	
}

@end
