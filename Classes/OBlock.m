//
//  OBlock.m
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OBlock.h"

#import "Board.h"

@implementation OBlock

- (instancetype)initWithBoard:(id)board
{
	if (!(self = [super initWithBoard:board])) return nil;
	
	return self;
}


- (void)build
{
	Board *b=[self board];
	
	cells[0]=[self createBlockCellAtX:b.width/2-1 Y:0];
	cells[1]=[self createBlockCellAtX:b.width/2-1 Y:1];
	cells[2]=[self createBlockCellAtX:b.width/2 Y:0];
	cells[3]=[self createBlockCellAtX:b.width/2 Y:1];
}

@end
