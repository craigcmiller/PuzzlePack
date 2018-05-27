//
//  MSMinesweeperViewController.h
//  Touchtris
//
//  Created by Craig Miller on 22/09/2014.
//
//

#import <UIKit/UIKit.h>

@class MSMinesweeperView;

@interface MSMinesweeperViewController : UIViewController<UIScrollViewDelegate>

- (instancetype)init:(void (^)(MSMinesweeperViewController *vc))postLoad;

@property (nonatomic, readonly, strong) MSMinesweeperView *minesweeperView;

@end
