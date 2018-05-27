//
//  Board.h
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardCell.h"
#import "CellRow.h"
#import "CellCollection.h"
#import "AbstractBlock.h"

#define ROWS_PER_LEVEL	10
#define SINGLE_ROW_SCORE_INCREMENT	10


@interface Board : NSObject {
	@private
	BOOL gameOver;
	int width, height;
	CellCollection *cells;
	AbstractBlock *__weak block;
	int updates;
	int level, rowsRemovedInLevel;
	int score;
	int nextBlockType;
}

+ (Board *)boardWithDefaults;

- (instancetype)initWithWidth:(int)w height:(int)h NS_DESIGNATED_INITIALIZER;

- (void)buildBoard;

- (void)setGameOver;

- (void)update;

/**
 * Add a random block to the board
 */
- (void)addRandomBlock;

/**
 * Get the time (in miliseconds) there should be between updates
 */
@property (NS_NONATOMIC_IOSONLY, getter=getTimeBetweenUpdates, readonly) int timeBetweenUpdates;

@property(readonly) CellCollection *cells;

@property(readonly) int width;

@property(readonly) int height;

@property(readonly) int level;

@property(readonly) int updates;

@property(weak) AbstractBlock *block;

@property(readonly) BOOL gameOver;

@property(readonly) int nextBlockType;

@property(readonly) int score;

@end
