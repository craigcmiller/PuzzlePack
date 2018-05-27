//
//  MSBoard.m
//  Minesweeper_cli
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MSBoard.h"



@implementation MSBoard

@synthesize rowCount;
@synthesize columnCount;
@synthesize mines;
@synthesize markers;
@synthesize won;
@synthesize gameOver;


typedef struct {
	uint32_t x, y;
} MSBoardPoint;


MSBoardPoint MSBoardPointMake(uint32_t x, uint32_t y)
{
	MSBoardPoint pt;
	pt.x = x;
	pt.y = y;
	
	return pt;
}

- (MSBoardPoint)generatePositionForMine:(int)numGenerated mines:(MSBoardPoint*)minesGenerated rows:(int)r columns:(int)c
{
	int x=random() % c, y=random() % r;
	
	for (int i=0; i<numGenerated; i++) {
		if (x==minesGenerated[i].x && y==minesGenerated[i].y)
			return [self generatePositionForMine:numGenerated mines:minesGenerated rows:r columns:c];
	}
	
	return MSBoardPointMake(x, y);
}

- (MSBoardPoint *)generateMinePositions:(int)numMines rows:(int)r columns:(int)c
{
	MSBoardPoint *positions=malloc(numMines * sizeof(MSBoardPoint));
	
	random();
	
	for (int i=0; i<numMines; i++) {
		positions[i]=[self generatePositionForMine:i mines:positions rows:r columns:c];
	}
	
	return positions;
}

- (void)generateCellMineCounts:(MSBoardPoint *)pos mines:(int)mineCount
{
	for (int i = 0; i < mineCount; i++) {
		int32_t x = pos[i].x, y = pos[i].y;
		MSCell *cell;
		
		//NSLog(@"%d, %d", x, y);
		
		// 3 cells in row above
		if (y>0) {
			if (x>0) {
				cell=[self cellAtX:x-1 Y:y-1];
				cell.surroundingMines++;
			}
			
			cell=[self cellAtX:x Y:y-1];
			cell.surroundingMines++;
			
			if (x<columnCount-1) {
				cell=[self cellAtX:x+1 Y:y-1];
				cell.surroundingMines++;
			}
		}
		
		// 3 cells in current row
		if (x>0) {
			cell=[self cellAtX:x-1 Y:y];
			cell.surroundingMines++;
		}
		
		// Mine cell
		cell=[self cellAtX:x Y:y];
		cell.hasMine=YES;
		cell.surroundingMines++;
		
		if (x<columnCount-1) {
			cell=[self cellAtX:x+1 Y:y];
			cell.surroundingMines++;
		}
		
		// 3 cells in next row
		if (y<rowCount-1) {
			if (x>0) {
				cell=[self cellAtX:x-1 Y:y+1];
				cell.surroundingMines++;
			}
			
			cell=[self cellAtX:x Y:y+1];
			cell.surroundingMines++;
			
			if (x<columnCount-1) {
				cell=[self cellAtX:x+1 Y:y+1];
				cell.surroundingMines++;
			}
		}
	}
}

+ (uint32_t)calculateNumberOfMinesForRows:(uint32_t)rows column:(uint32_t)columns difficulty:(float)difficulty
{
	return (uint32_t)(((float)(rows * columns)) / (3.2f * difficulty));;
}

- (instancetype)initWithRows:(uint32_t)r columns:(uint32_t)c difficulty:(float)difficulty
{
	if (self=[super init]) {
		won = NO;
		rowCount = r;
		columnCount = c;
		
		//mines = (int)(((float)(r * c)) / 6.4f);
		mines = [MSBoard calculateNumberOfMinesForRows:r column:c difficulty:difficulty];
		
		MSBoardPoint *minePositions = [self generateMinePositions:mines rows:r columns:c];
		
		rows = [[NSMutableArray alloc] initWithCapacity:r];
		
		for (int y = 0; y < r; y++) {
			NSMutableArray *row=[[NSMutableArray alloc] initWithCapacity:c];
			
			for (int x = 0; x < c; x++)
				[row addObject:[[MSCell alloc] init]];
			
			[((NSMutableArray *)rows) addObject:row];
		}
		
		[self generateCellMineCounts:minePositions mines:mines];
		
		free(minePositions);
	}
	
	return self;
}

- (MSCell *)cellAtX:(int)x Y:(int)y
{
	return rows[y][x];
}

- (void)showEmptyCellsFromX:(int)x Y:(int)y
{
	if (x < 0 || x >= columnCount || y < 0 || y >= rowCount)
		return;
	
	MSCell *cell = [self cellAtX:x Y:y];
	
	if (!cell.isHidden || cell.hasMarker) return;
	
	if (!cell.hasMine) {
		cell.isHidden = NO;
		
		if (cell.surroundingMines == 0) {
			[self showEmptyCellsFromX:x + 1 Y:y];
			[self showEmptyCellsFromX:x - 1 Y:y];
			[self showEmptyCellsFromX:x Y:y + 1];
			[self showEmptyCellsFromX:x Y:y - 1];
			
			[self showEmptyCellsFromX:x + 1 Y:y - 1];
			[self showEmptyCellsFromX:x + 1 Y:y + 1];
			[self showEmptyCellsFromX:x - 1 Y:y - 1];
			[self showEmptyCellsFromX:x - 1 Y:y + 1];
		}
	}
}

- (void)unhideAllCells
{
	for (NSArray *row in rows) {
		for (MSCell *cell in row) {
			cell.hasMarker=NO;
			cell.isHidden=NO;
		}
	}
}

- (BOOL)gameWon
{
	for (int y = 0; y < rowCount; y++) {
		for (int x = 0; x < columnCount; x++) {
			MSCell *cell=[self cellAtX:x Y:y];
			if (cell.isHidden && !cell.hasMine)
				return NO;
		}
	}
	
	return YES;
}

- (MSCellActivationResult)activateCellAtX:(int)x Y:(int)y
{
	MSCell *activatedCell=[self cellAtX:x Y:y];
	
	if (gameOver) return MSCellActivationMineExploded;
	else if (won) return MSCellActivationGameWon;
	
	if (activatedCell.hasMarker)
		return MSCellActivationMarker;
	
	if (activatedCell.hasMine) {
		[self unhideAllCells];
		
		gameOver=YES;
		
		return MSCellActivationMineExploded;
	}
	
	[self showEmptyCellsFromX:x Y:y];
	
	if (won || [self gameWon]) {
		won=YES;
		[self unhideAllCells];
		
		return MSCellActivationGameWon;
	}
	
	return MSCellActivationSuccess;
}

- (BOOL)addMarkerAtX:(int)x Y:(int)y
{
	MSCell *cell=[self cellAtX:x Y:y];
	
	if (gameOver || won) return NO;
	
	if (!cell.isHidden) return NO;
	
	cell.hasMarker=!cell.hasMarker;
	
	if (cell.hasMarker) markers++;
	else markers--;
	
	return YES;
}

- (NSString *)toString:(BOOL)showAll
{
	NSMutableString *str=[NSMutableString stringWithString:@"\n"];
	
	for (int y=0; y<rowCount; y++) {
		for (int x=0; x<columnCount; x++) {
			MSCell *c=[self cellAtX:x Y:y];
			
			if (!showAll && c.isHidden) {
				[str appendString:@"="];
			} else {
				if (c.hasMine)
					[str appendString:@"x"];
				else if (c.surroundingMines > 0)
					[str appendFormat:@"%d", c.surroundingMines];
				else
					[str appendString:@"_"];
			}
			
			[str appendString:@" "];
		}
		
		[str appendString:@"\n"];
	}
	
	return str;
}

@end
