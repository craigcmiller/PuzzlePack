//
//  TicTacToeSetupViewController.h
//  Touchtris
//
//  Created by Craig Miller on 29/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TicTacToeView.h"


@interface TicTacToeSetupViewController : UIViewController {
	IBOutlet TicTacToeView *ticTacToeView;
	IBOutlet UIWindow *gameWindow;
	IBOutlet UISegmentedControl *sideSelector;
	IBOutlet UILabel *statusField;
}

- (IBAction)beginGame:(id)sender;

- (IBAction)endGame:(id)sender;

@property(nonatomic, strong) TicTacToeView *ticTacToeView;
@property(nonatomic, strong) UIWindow *gameWindow;
@property(nonatomic, strong) UISegmentedControl *sideSelector;
@property(nonatomic, strong) UILabel *statusField;

@end
