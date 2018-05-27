//
//  MSMinesweeperView.h
//  Touchtris
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSBoard.h"
#import "MSCell.h"


@interface MSMinesweeperView : UIView {
	IBOutlet UILabel *__weak infoLabel;
	IBOutlet UILabel *__weak timeLabel;
	@private
	MSBoard *board;
	NSTimer *gameTimeTimer;
	int secondsSinceStart;
}

- (instancetype)init;

- (void)newGameWithRows:(int)rows columns:(int)columns difficulty:(float)difficulty;

@property (weak, nonatomic) UILabel *infoLabel;

@property (weak, nonatomic) UILabel *timeLabel;

@end
