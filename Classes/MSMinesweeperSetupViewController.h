//
//  MSMinesweeperViewController.h
//  Touchtris
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMinesweeperSetupViewController : UIViewController {
}

- (IBAction)startGame:(id)sender;

- (IBAction)changeGridSize:(UISlider *)sender;

- (IBAction)difficultyChanged:(UISlider *)sender;

@property (strong, nonatomic) IBOutlet UILabel *gridSizeLabel;

@property (strong, nonatomic) IBOutlet UISlider *gridSizeSlider;

@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;

@property (weak, nonatomic) IBOutlet UISlider *difficultySlider;

@end
