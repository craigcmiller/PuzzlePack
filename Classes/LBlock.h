//
//  LBlock.h
//  MiniTetris
//
//  Created by Craig Miller on 12/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AbstractBlock.h"


@interface LBlock : AbstractBlock {
	@private
	int rotation;
}

- (instancetype)initWithBoard:(id)board NS_DESIGNATED_INITIALIZER;

@end
