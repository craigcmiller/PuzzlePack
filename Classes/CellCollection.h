//
//  CellCollection.h
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellRow.h"

@interface CellCollection : NSObject {
@private
	int rowCount;
	int rowLength;
	NSMutableArray *cellRows;
}

- (instancetype)initWithRows:(int)numRows rowLength:(int)rowLen NS_DESIGNATED_INITIALIZER;

/* Get a cell row at an index */
- (CellRow *)getRow:(int)idx;

/**
 * Get a cell at a specific location
 * @return A cell or null if the range is outwith the board
 */
- (BoardCell *)getCellAtX:(int)x Y:(int)y;

@property(readonly) int rowCount;

@property(readonly) int rowLength;

@end
