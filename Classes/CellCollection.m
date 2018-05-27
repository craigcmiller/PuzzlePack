//
//  CellCollection.m
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CellCollection.h"


@implementation CellCollection

@synthesize rowCount;
@synthesize rowLength;


- (instancetype)initWithRows:(int)numRows rowLength:(int)rowLen
{
	if (!(self = [super init])) return nil;
	
	rowCount=numRows;
	rowLength=rowLen;
	
	cellRows=[[NSMutableArray alloc] init];
	
	int i;
	for (i=0; i<rowCount; i++) {
		[cellRows addObject:[[CellRow alloc] initWithLength:rowLen]];
	}
	
	return self;
}




- (CellRow *)getRow:(int)idx
{
	return cellRows[idx];
}


/**
 * Get a cell at a specific location
 * @return A cell or null if the range is outwith the board
 */
- (BoardCell *)getCellAtX:(int)x Y:(int)y
{
	if (x<0 || x>rowLength || y<0 || y>rowCount) return nil;
	
	return [[self getRow:y] getCell:x];
}

@end
