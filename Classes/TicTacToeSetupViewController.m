//
//  TicTacToeSetupViewController.m
//  Touchtris
//
//  Created by Craig Miller on 29/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TicTacToeSetupViewController.h"


@implementation TicTacToeSetupViewController

@synthesize ticTacToeView;
@synthesize gameWindow;
@synthesize sideSelector;
@synthesize statusField;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)beginGame:(id)sender
{
	[gameWindow makeKeyAndVisible];
	
	[ticTacToeView newGame:[sideSelector selectedSegmentIndex]+1 textField:statusField];
}

- (IBAction)endGame:(id)sender
{
	[gameWindow setHidden:YES];
	[self.view.window makeKeyAndVisible];
	//[self.view.window becomeFirstResponder];
	//[self.view.window setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}




@end
