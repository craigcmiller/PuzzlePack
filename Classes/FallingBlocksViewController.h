//
//  TouchtrisAppDelegate.h
//  Touchtris
//
//  Created by Craig Miller on 10/06/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TetrisView.h"

@interface FallingBlocksViewController : UIViewController {
	IBOutlet UIWindow *gameWindow;
	IBOutlet UIWindow *gameSetupWindow;
	IBOutlet UIWindow *gameOverWindow;
	IBOutlet UISegmentedControl *boardWidthSegmentControl;
	IBOutlet UISegmentedControl *boardHeightSegmentControl;
	IBOutlet UIImageView *nextBlockImage;
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *levelLabel;
	
	@private
	UIImage *iBlockImage, *lBlockImage, *oBlockImage, *reverseLBlockImage, *reverseZBlockImage, *tBlockImage, *zBlockImage;
}

/* Show the new game window */
- (IBAction)newGame:(id)sender;

- (IBAction)startGame:(id)sender;

- (IBAction)endGame:(id)sender;

- (IBAction)gotoWebsite:(id)sender;

- (void)updateNextBlock:(int)blockType;

- (void)setGameOver;

@end

