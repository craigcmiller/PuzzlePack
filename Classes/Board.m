//
//  Board.m
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Board.h"

#import "IBlock.h"
#import "LBlock.h"
#import "OBlock.h"
#import "ReverseLBlock.h"
#import "TBlock.h"
#import "ZBlock.h"
#import "ReverseZBlock.h"


@implementation Board

@synthesize cells;
@synthesize height;
@synthesize width;
@synthesize level;
@synthesize updates;
@synthesize block;
@synthesize gameOver;
@synthesize nextBlockType;
@synthesize score;


+ (Board *)boardWithDefaults
{
	return [[Board alloc] initWithWidth:10 height:20];
}


- (instancetype)initWithWidth:(int)w height:(int)h
{
	if (!(self = [super init])) return nil;
	
	gameOver=NO;
	width=w;
	height=h;
	updates=0;
	level=1;
	rowsRemovedInLevel=0;
	score=0;
	block=nil;
	nextBlockType=-1;
	
	[self buildBoard];
	
	return self;
}




/**
 * Allocate and setup the board
 */
- (void)buildBoard
{
	cells=[[CellCollection alloc] initWithRows:height rowLength:width];
	
	int i, j;
	for (i=0; i<height; i++) {
		for (j=0; j<width; j++) {
			[cells getCellAtX:j Y:i].cellState=CellStateEmpty;
		}
	}
}


- (void)update
{
	if (gameOver) return;
	
	// Call random to try and get a more random value for the next block
	random();
	
	// If there is no block yet create one
	if (block==nil) [self addRandomBlock];
	
	[block moveDown];
	
	// Disable the current block so that updates do not effect it
	[block setCellStatesForBlock:CellStateEmpty];
	
	int rowsRemovedInUpdate=0;
	
	// Check for any lines to eliminate
	int i;
	for (i=cells.rowCount-1; i>=0; i--) {
		BOOL rowComplete=YES;
		
		int j;
		for (j=0; j<cells.rowLength; j++) {
			BoardCell *c=[cells getCellAtX:j Y:i];
			if (c.cellState==CellStateEmpty) {
				rowComplete=NO;
				break; // There is an empty cell so this row is not yet full
			}
		}
		
		if (!rowComplete) continue;
		
		// All cells are set so move all rows above down
		for (j=i; j>0; j--) {
			int k;
			for (k=0; k<cells.rowLength; k++) {
				[[cells getCellAtX:k Y:j] copyPropertiesFromCell:[cells getCellAtX:k Y:j-1]];
			}
		}
		
		i++; // Increment i so that the row will be checked again
		
		rowsRemovedInUpdate++;
		
		// Check if the level is completed
		if (++rowsRemovedInLevel==ROWS_PER_LEVEL) {
			// Up the level
			level++;
			rowsRemovedInLevel=0;
		}
	}
	
	switch (rowsRemovedInUpdate) {
		case 1:
			score+=SINGLE_ROW_SCORE_INCREMENT;
			break;
		case 2:
			score+=SINGLE_ROW_SCORE_INCREMENT*2+2;
			break;
		case 3:
			score+=SINGLE_ROW_SCORE_INCREMENT*3+SINGLE_ROW_SCORE_INCREMENT/2;
			break;
		case 4:
			score+=SINGLE_ROW_SCORE_INCREMENT*5;
			break;
	}
	
	// Reenable the current block
	[block setCellStatesForBlock:CellStateSet];
	
	updates++;
}


- (void)setGameOver
{
	gameOver=YES;
}


- (AbstractBlock *)createBlock
{
	AbstractBlock *newBlock;
	
	switch (nextBlockType) {
		case 0:
			newBlock=[[IBlock alloc] initWithBoard:self];
			break;
		case 1:
			newBlock=[[OBlock alloc] initWithBoard:self];
			break;
		case 2:
			newBlock=[[LBlock alloc] initWithBoard:self];
			break;
		case 3:
			newBlock=[[ReverseLBlock alloc] initWithBoard:self];
			break;
		case 4:
			newBlock=[[TBlock alloc] initWithBoard:self];
			break;
		case 5:
			newBlock=[[ZBlock alloc] initWithBoard:self];
			break;
		case 6:
			newBlock=[[ReverseZBlock alloc] initWithBoard:self];
			break;
		default:
			newBlock=nil;
			break;
	}
	
	return newBlock;
}


/**
 * Add a random block to the board
 */
- (void)addRandomBlock
{
	if (nextBlockType==-1) nextBlockType=random() % 7;
	
	block=[self createBlock];
	
	nextBlockType=random() % 7;
}


/**
 * Get the time (in miliseconds) there should be between updates
 */
- (int)getTimeBetweenUpdates
{
	return (int)(1000/(level*0.8));
}


- (void)saveToFile
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=paths[0];
	
	NSString *filePath=[documentsDirectory stringByAppendingPathComponent:@"CurrentGame.data"];
	
	NSMutableData *data=[[NSMutableData alloc] initWithCapacity:width*height];
	
	
	[data writeToFile:filePath atomically:YES];
	
}

@end
