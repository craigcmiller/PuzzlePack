//
//  TouchtrisAppDelegate.m
//  Touchtris
//
//  Created by Craig Miller on 10/06/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FallingBlocksViewController.h"

#import "TetrisViewController.h"

@interface FallingBlocksViewController()
{
	TetrisViewController *_tetrisViewController;
}
@end

@implementation FallingBlocksViewController


- (UIImage *)getImage:(NSString *)path
{
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	random();
	
	// Load next block images
	iBlockImage=[self getImage:@"IBlock"];
	lBlockImage=[self getImage:@"LBlock"];
	oBlockImage=[self getImage:@"OBlock"];
	reverseLBlockImage=[self getImage:@"ReverseLBlock"];
	reverseZBlockImage=[self getImage:@"ReverseZBlock"];
	tBlockImage=[self getImage:@"TBlock"];
	zBlockImage=[self getImage:@"ZBlock"];
}




/* Show the new game window */
- (IBAction)newGame:(id)sender
{	
	[gameSetupWindow makeKeyAndVisible];
}


- (IBAction)startGame:(id)sender
{
	_tetrisViewController = [[TetrisViewController alloc] init];
	
	int boardWidth, boardHeight;
	
	switch (boardWidthSegmentControl.selectedSegmentIndex) {
		case 0:
			boardWidth=10;
			break;
		case 1:
			boardWidth=12;
			break;
	}
	
	switch (boardHeightSegmentControl.selectedSegmentIndex) {
		case 0:
			boardHeight=18;
			break;
		case 1:
			boardHeight=20;
			break;
		case 2:
			boardHeight=22;
			break;
	}
	
	[gameSetupWindow setHidden:YES];
	
	[gameWindow makeKeyAndVisible];
	
	_tetrisViewController.tetrisView.appDelegate=self;
	
	[_tetrisViewController.tetrisView startNewGameWithBoardWidth:boardWidth height:boardHeight];
}


- (IBAction)endGame:(id)sender
{
	[_tetrisViewController.tetrisView endGame];
	//[tetrisView release];
	[gameWindow setHidden:YES];
	
	/*[window makeKeyAndVisible];
	[window becomeFirstResponder];
	[window setUserInteractionEnabled:YES];*/
}


- (IBAction)gotoWebsite:(id)sender
{
	NSURL *url=[[NSURL alloc] initWithString:@"http://www.craigcmiller.com"];
	[[UIApplication sharedApplication] openURL:url];
}

- (void)updateNextBlock:(int)blockType
{
	switch (blockType) {
		case 0:
			nextBlockImage.image=iBlockImage;
			break;
		case 1:
			nextBlockImage.image=oBlockImage;
			break;
		case 2:
			nextBlockImage.image=lBlockImage;
			break;
		case 3:
			nextBlockImage.image=reverseLBlockImage;
			break;
		case 4:
			nextBlockImage.image=tBlockImage;
			break;
		case 5:
			nextBlockImage.image=zBlockImage;
			break;
		case 6:
			nextBlockImage.image=reverseZBlockImage;
			break;
	}
	
	scoreLabel.text=[NSString stringWithFormat:@"Score: %d", _tetrisViewController.tetrisView.board.score];
	levelLabel.text=[NSString stringWithFormat:@"Level: %d", _tetrisViewController.tetrisView.board.level];
}


- (void)setGameOver
{
	[gameOverWindow makeKeyAndVisible];
}

@end
