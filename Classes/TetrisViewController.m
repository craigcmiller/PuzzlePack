//
//  TetrisViewController.m
//  Touchtris
//
//  Created by Craig Miller on 01/10/2014.
//
//

#import "TetrisViewController.h"

#import "TetrisView.h"

@interface TetrisViewController ()

@end

@implementation TetrisViewController

- (instancetype)init
{
	if (self = [super init]) {
		self.view = _tetrisView = [[TetrisView alloc] init];
	}
	
	return self;
}

- (void)loadView
{
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
