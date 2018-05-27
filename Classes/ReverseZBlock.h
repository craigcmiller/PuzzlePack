//
//  ReverseZBlock.h
//  MiniTetris
//
//  Created by Craig Miller on 13/06/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AbstractBlock.h"

@interface ReverseZBlock : AbstractBlock {
	@private
	BOOL horizontal;
}

- (instancetype)initWithBoard:(id)board NS_DESIGNATED_INITIALIZER;

@end
