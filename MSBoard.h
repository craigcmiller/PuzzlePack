//
//  MSBoard.h
//  Minesweeper_cli
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSCell.h"


@interface MSBoard : NSObject {
	@private
	NSArray *rows;
	uint32_t rowCount;
	uint32_t columnCount;
	uint32_t mines;
	uint32_t markers;
	BOOL won;
	BOOL gameOver;
}

+ (uint32_t)calculateNumberOfMinesForRows:(uint32_t)rows column:(uint32_t)columns difficulty:(float)difficulty;

- (instancetype)initWithRows:(uint32_t)r columns:(uint32_t)c difficulty:(float)difficulty NS_DESIGNATED_INITIALIZER;

- (MSCell *)cellAtX:(int)x Y:(int)y;

- (MSCellActivationResult)activateCellAtX:(int)x Y:(int)y;

- (BOOL)addMarkerAtX:(int)x Y:(int)y;

- (NSString *)toString:(BOOL)showAll;

@property (readonly, nonatomic) uint32_t rowCount;
@property (readonly, nonatomic) uint32_t columnCount;
@property (readonly, nonatomic) uint32_t mines;
@property (readonly, nonatomic) uint32_t markers;
@property (readonly, nonatomic) BOOL won;
@property (readonly, nonatomic) BOOL gameOver;

@end
