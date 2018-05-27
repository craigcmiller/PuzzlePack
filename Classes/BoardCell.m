//
//  Cell.m
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BoardCell.h"


@implementation BoardCell

@synthesize cellState;
@synthesize red;
@synthesize green;
@synthesize blue;


/**
 * Construct a cell
 * @param cellState
 */
- (instancetype)initWithState:(CellStateValue)state
{
	if (!(self = [super init])) return nil;
	
	cellState=state;
	red=1;
	green=1;
	blue=1;
	
	return self;
}




/**
 * Take the properties of another cell
 * @param c
 */
- (void)copyPropertiesFromCell:(BoardCell *)c
{
	self.cellState=c.cellState;
	
	self.red=c.red;
	self.green=c.green;
	self.blue=c.blue;
}


/**
 * Return a character representation of this cell
 */
- (NSString *)toString
{
	if (cellState==CellStateEmpty) return @"_";
	else if (cellState==CellStateSet) return @"O";
	
	return @"E";
}

@end
