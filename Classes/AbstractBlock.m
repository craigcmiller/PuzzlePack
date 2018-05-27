//
//  Test.m
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AbstractBlock.h"

#import "Board.h"


@implementation AbstractBlock

Board *board;


/**
 * Construct a block
 */
- (instancetype)initWithBoard:(id)parentBoard
{
	if (!(self = [super init])) return nil;
	
	board=(Board *)parentBoard;
	
	[self build];
	
	float red=[self makeRandomColorComponent], green=[self makeRandomColorComponent], blue=[self makeRandomColorComponent];
	
	int i;
	// Iterate through all cells of the block
	for (i=0; i<4; i++) {
		BoardCell *c=[self getCellForBlockCell:cells[i]];
		
		// Check all cells are empty before filling them
		if (c.cellState !=CellStateEmpty) {
			[board setGameOver];
			return self;
		} else {
			c.cellState=CellStateSet;
			c.red=red;
			c.green=green;
			c.blue=blue;
		}
	}
	
	return self;
}




- (float)makeRandomColorComponent
{
	float rnd=random();
	
	while (rnd > 1) rnd /= 10;
	
	return rnd;
}


/**
 * Update board cell states for a block's cells
 */
- (void)setCellStatesForBlock:(CellStateValue)newCellState
{
	// Iterate through all cells of the block
	int i;
	for (i=0; i<4; i++)
		[self getCellForBlockCell:cells[i]].cellState=newCellState;
}


/**
 * Get a board cell for a block cell
 */
- (BoardCell *)getCellForBlockCell:(BlockCell)blockCell
{
	return [board.cells getCellAtX:blockCell.x Y:blockCell.y];
}


/**
 * Check if a cell move is legal
 */
- (BOOL)isCellMoveLegalAt:(int)idx XOffset:(int)xoffset YOffset:(int)yoffset
{
	if (cells[idx].x+xoffset < 0 || cells[idx].x+xoffset >= board.width) return NO;
	
	return [board.cells getCellAtX:cells[idx].x+xoffset Y:cells[idx].y+yoffset].cellState==CellStateEmpty;
}


/**
 * Move a single cell by an offset. Does not check if move is legal
 */
- (void)moveCellAt:(int)idx XOffset:(int)xoffset YOffset:(int)yoffset
{
	[[board.cells getCellAtX:cells[idx].x+xoffset Y:cells[idx].y+yoffset] copyPropertiesFromCell:[board.cells getCellAtX:cells[idx].x Y:cells[idx].y]];
	
	[board.cells getCellAtX:cells[idx].x Y:cells[idx].y].cellState=CellStateEmpty;
	
	cells[idx].x+=xoffset;
	cells[idx].y+=yoffset;
	
	[board.cells getCellAtX:cells[idx].x Y:cells[idx].y].cellState=CellStateSet;
}


/**
 * Check if it is safe to move by a certain offset
 */
- (BOOL)isSafeMoveX:(int)xoffset Y:(int)yoffset
{
	// Deactivate the current cells so we do not look at them
	[self setCellStatesForBlock:CellStateEmpty];
	
	int i;
	for (i=0; i<4; i++)
		if (cells[i].y+yoffset==board.height || cells[i].x+xoffset<0 || cells[i].x+xoffset>=board.width
			|| [board.cells getCellAtX:cells[i].x+xoffset Y:cells[i].y+yoffset].cellState !=CellStateEmpty) {
			// Reactivate the current cells
			[self setCellStatesForBlock:CellStateSet];
			
			return NO;
		}
	
	// Reactivate the current cells
	[self setCellStatesForBlock:CellStateSet];
	
	return YES;
}


/**
 * Move the block by an offset
 */
- (void)moveBlockToX:(int)xoffset Y:(int)yoffset
{
	[self setCellStatesForBlock:CellStateEmpty];
	
	int i;
	for (i=0; i<4; i++) {
		[[board.cells getCellAtX:cells[i].x+xoffset Y:cells[i].y+yoffset] copyPropertiesFromCell:[board.cells getCellAtX:cells[i].x Y:cells[i].y]];
		
		cells[i].x+=xoffset;
		cells[i].y+=yoffset;
	}
	
	[self setCellStatesForBlock:CellStateSet];
}


/**
 * Implement to provide initial creation of the block
 */
- (void)build
{
}


/**
 * Implement to provide block type specific rotation
 */
- (void)rotate
{
}


/**
 * Move the block down one
 */
- (void)moveDown
{
	if ([self isSafeMoveX:0	Y:1]) [self moveBlockToX:0 Y:1];
	else {
		[board addRandomBlock];
	}
}


- (void)moveLeft
{
	if ([self isSafeMoveX:-1 Y:0]) [self moveBlockToX:-1 Y:0];
}


- (void)moveRight
{
	if ([self isSafeMoveX:1 Y:0]) [self moveBlockToX:1 Y:0];
}


- (BlockCell)createBlockCellAtX:(int)x Y:(int)y
{
	BlockCell bc;
	bc.x=x;
	bc.y=y;
	
	return bc;
}


- (id)board
{
	return board;
}

@end

