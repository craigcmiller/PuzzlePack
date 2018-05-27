#import "GameSelectionController.h"
#import "FallingBlocksViewController.h"
#import "TicTacToeSetupViewController.h"
#import "MSMinesweeperSetupViewController.h"

@implementation GameSelectionController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
	}
	
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Choose a Game";
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


/* Setup a game menu cell */
- (void)setupCell:(UITableViewCell *)cell text:(NSString *)text imageFile:(NSString *)imageFile
{
	cell.textLabel.text = text;
	cell.imageView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageFile ofType:@"png"]];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell=[[UITableViewCell alloc] init];
	
    switch (indexPath.row) {
		case 0: // Falling blocks
			[self setupCell:cell text:@"Falling Blocks" imageFile:@"FallingBlocksMenuItem"];
			break;
		case 1: // Tic tac toe
			[self setupCell:cell text:@"Tic Tac Toe" imageFile:@"TicTacToeMenuItem"];
			break;
		case 2: // Minesweeper
			[self setupCell:cell text:@"Minesweeper" imageFile:@"MinesweeperMenuItem"];
			break;
		default:
			//[[NSBundle mainBundle]
			break;
	}
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0: // Falling blocks
			{
				FallingBlocksViewController *fallingBlocksViewController=[[FallingBlocksViewController alloc] initWithNibName:@"FallingBlocks" bundle:nil];
				[self.navigationController pushViewController:fallingBlocksViewController animated:YES];
			}
			break;
		case 1: // Tic Tac Toe
			{
				TicTacToeSetupViewController *tickTacToeSetupViewController=[[TicTacToeSetupViewController alloc] initWithNibName:@"TicTacToeView" bundle:nil];
				[self.navigationController pushViewController:tickTacToeSetupViewController animated:YES];
			}
			break;
		case 2: // Minesweeper
			{
				MSMinesweeperSetupViewController *minesweeperViewController=[[MSMinesweeperSetupViewController alloc] initWithNibName:@"MinesweeperSetupView" bundle:nil];
				[self.navigationController pushViewController:minesweeperViewController animated:YES];
			}
			break;
		default:
			break;
	}
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



@end
