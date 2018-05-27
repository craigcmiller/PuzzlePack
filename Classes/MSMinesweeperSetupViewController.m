//
//  MSMinesweeperViewController.m
//  Touchtris
//
//  Created by Craig Miller on 31/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MSMinesweeperSetupViewController.h"

#import "MSMinesweeperViewController.h"
#import "MSMinesweeperView.h"


@implementation MSMinesweeperSetupViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Minesweeper";
    }
    return self;
}

- (void)viewDidLoad
{
	[self updateGirdSizeAndDifficultyLabels];
}

- (float)difficultyValue
{
	return 5 - self.difficultySlider.value;
}

- (IBAction)startGame:(id)sender
{
	int gridSize = (int)self.gridSizeSlider.value;
	
	MSMinesweeperViewController *minesweeperViewController = [[MSMinesweeperViewController alloc] init:^(MSMinesweeperViewController *vc){
		[vc.minesweeperView newGameWithRows:gridSize columns:gridSize difficulty:[self difficultyValue]];
	}];
	
	[self.navigationController pushViewController:minesweeperViewController animated:YES];
}

- (void)updateGirdSizeAndDifficultyLabels
{
	self.gridSizeLabel.text = [NSString stringWithFormat:@"Grid Size (%dx%d):", (int32_t)self.gridSizeSlider.value, (int32_t)self.gridSizeSlider.value];
	
	self.difficultyLabel.text = [NSString stringWithFormat:@"Difficulty: (%d Mines):", [MSBoard calculateNumberOfMinesForRows:self.gridSizeSlider.value column:self.gridSizeSlider.value difficulty:[self difficultyValue]]];
}

- (IBAction)changeGridSize:(UISlider *)sender
{
	[self updateGirdSizeAndDifficultyLabels];
}

- (IBAction)difficultyChanged:(UISlider *)sender
{
	[self updateGirdSizeAndDifficultyLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


@end
