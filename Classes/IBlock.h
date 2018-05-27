//
//  IBlock.h
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellCollection.h"
#import "BoardCell.h"
#import "Board.h"
#import "CellRow.h"
#import "AbstractBlock.h"


@interface IBlock : AbstractBlock {
	@private
	BOOL horizontal;
	BlockCell rotationCell;
}

- (instancetype)initWithBoard:(id)board NS_DESIGNATED_INITIALIZER;

@end
