//
//  MSCell.m
//  Minesweeper_cli
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MSCell.h"


@implementation MSCell

@synthesize surroundingMines;
@synthesize hasMine;
@synthesize isHidden;
@synthesize hasMarker;

- (instancetype)init
{
	if (self=[super init]) {
		surroundingMines=0;
		hasMine=NO;
		isHidden=YES;
	}
	
	return self;
}

@end
