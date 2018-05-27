//
//  CellRow.h
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardCell.h"


@interface CellRow : NSObject {
	@private
	NSMutableArray *cells;
	int length;
}

- (instancetype)initWithLength:(int)len NS_DESIGNATED_INITIALIZER;

/* Add a cell to the row */
- (void)addCell:(BoardCell *)c;

/* Get a cell at an index */
- (BoardCell *)getCell:(int)idx;

@property(readonly) int length;

@end
