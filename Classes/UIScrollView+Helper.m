//
//  UIScrollView+Helper.m
//  Touchtris
//
//  Created by Craig Miller on 02/11/2014.
//
//

#import "UIScrollView+Helper.h"

@implementation UIScrollView (Helper)

- (void)centerOnPoint:(CGPoint)point animated:(BOOL)animated
{
	CGRect viewFrame = self.frame;
	
	CGPoint pt = CGPointMake(point.x - viewFrame.size.width / 2, point.y - viewFrame.size.height / 2);
	
	[self setContentOffset:pt animated:animated];
}

@end
