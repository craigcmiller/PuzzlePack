//
//  MSCell.h
//  Minesweeper_cli
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MSCellActivationResult) {
	MSCellActivationMineExploded,
	MSCellActivationSuccess,
	MSCellActivationMarker,
	MSCellActivationGameWon
};


@interface MSCell : NSObject {
	@private
	uint32_t surroundingMines;
	BOOL hasMine;
	BOOL isHidden;
	BOOL hasMarker;
}

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) uint32_t surroundingMines;
@property (nonatomic, assign) BOOL hasMine;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) BOOL hasMarker;

@end
