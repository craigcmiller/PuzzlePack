//
//  Test.h
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellCollection.h"
#import "BoardCell.h"
#import "CellRow.h"


typedef struct {
	int x;
	int y;
} BlockCell;


@interface AbstractBlock : NSObject {
	@protected
		BlockCell cells[4];
}

/**
 * Construct a block
 */
- (instancetype)initWithBoard:(id)parentBoard NS_DESIGNATED_INITIALIZER;

- (float)makeRandomColorComponent;

/**
 * Update board cell states for a block's cells
 */
- (void)setCellStatesForBlock:(CellStateValue)newCellState;

/**
 * Get a board cell for a block cell
 */
- (BoardCell *)getCellForBlockCell:(BlockCell)blockCell;

/**
 * Check if a cell move is legal
 */
- (BOOL)isCellMoveLegalAt:(int)idx XOffset:(int)xoffset YOffset:(int)yoffset;

/**
 * Move a single cell by an offset. Does not check if move is legal
 */
- (void)moveCellAt:(int)idx XOffset:(int)xoffset YOffset:(int)yoffset;

/**
 * Check if it is safe to move by a certain offset
 */
- (BOOL)isSafeMoveX:(int)xoffset Y:(int)yoffset;

/**
 * Move the block by an offset
 */
- (void)moveBlockToX:(int)xoffset Y:(int)yoffset;

/**
 * Move the block down one
 */
- (void)moveDown;

- (void)moveLeft;

- (void)moveRight;

/**
 * Implement to provide initial creation of the block
 */
- (void)build;

/**
 * Implement to provide block type specific rotation
 */
- (void)rotate;

/**
 * Setup a block cell
 */
- (BlockCell)createBlockCellAtX:(int)x Y:(int)y;

/**
 * Gets the board
 */
@property (NS_NONATOMIC_IOSONLY, readonly, strong) id board;

@end
