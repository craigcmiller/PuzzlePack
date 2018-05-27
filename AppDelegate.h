#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "AppTabBarController.h"

@interface AppDelegate : UIResponder<UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
	IBOutlet UITabBarController *tabBarController;
	
	@private
	UIViewController *aboutBoxViewController;
}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end
