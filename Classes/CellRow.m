//
//  CellRow.m
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CellRow.h"


@implementation CellRow

@synthesize length;

- (instancetype)initWithLength:(int)len
{
	if (!(self = [super init])) return nil;
	
	cells=[[NSMutableArray alloc] init];
	length=len;
	
	// Add cells for the row length
	int i;
	for (i=0; i<len; i++) {
		[cells addObject:[[BoardCell alloc] initWithState:CellStateEmpty]];
	}
	
	return self;
}

- (void)addCell:(BoardCell *)c
{
	[cells addObject:c];
}

- (BoardCell *)getCell:(int)idx
{
	return cells[idx];
}

@end
