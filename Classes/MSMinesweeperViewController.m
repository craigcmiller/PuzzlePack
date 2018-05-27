//
//  MSMinesweeperViewController.m
//  Touchtris
//
//  Created by Craig Miller on 22/09/2014.
//
//

#import "MSMinesweeperViewController.h"

#import "MSMinesweeperView.h"
#import "MSInformationViewController.h"
#import "UIView+Helper.h"
#import "MSScrollView.h"

@interface MSMinesweeperViewController ()
{
	MSScrollView *_scrollView;
	MSInformationViewController	*_informationViewController;
	void (^_postLoad)(MSMinesweeperViewController *vc);
}
@end

@implementation MSMinesweeperViewController

- (instancetype)init:(void (^)(MSMinesweeperViewController *vc))postLoad
{
	if (self = [super init]) {
		_postLoad = postLoad;
	}
	
	return  self;
}

- (void)loadView
{
	[super loadView];
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	self.title = @"Minesweeper";
	
	_scrollView = [[MSScrollView alloc] init];
	_scrollView.delegate = self;
	_scrollView.maximumZoomScale = 4;
	_scrollView.minimumZoomScale = 1 / 4;
	_scrollView.contentInset = UIEdgeInsetsMake(200, 200, 200, 200);
	_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_scrollView.backgroundColor = [UIColor blackColor];
	
	_scrollView.frame = self.view.frame;
	
	[self.view addSubview:_scrollView];
	
	_minesweeperView = [[MSMinesweeperView alloc] init];
	[_scrollView addSubview:_minesweeperView];
	
	_informationViewController = [[MSInformationViewController alloc] initWithNibName:@"MSInformationViewController" bundle:nil];
	_informationViewController.view.width = self.view.width;
	
	[self.view addSubview:_informationViewController.view];
	
	_minesweeperView.timeLabel = _informationViewController.timeLabel;
	_minesweeperView.infoLabel = _informationViewController.statusLabel;
	
	_postLoad(self);
}

- (void)viewDidAppear:(BOOL)animated
{
	/*NSLog(@"%f, %f, %f, %f", _informationViewController.view.x, _informationViewController.view.y, _informationViewController.view.width, _informationViewController.view.height);
	
	NSLog(@"V: %f, %f, %f, %f", self.view.x, self.view.y, self.view.width, self.view.height);
	NSLog(@"SV: %f, %f, %f, %f", _scrollView.x, _scrollView.y, _scrollView.width, _scrollView.height);*/
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _minesweeperView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
