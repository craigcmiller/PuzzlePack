//
//  UIView+Helper.h
//  Touchtris
//
//  Created by Craig Miller on 02/11/2014.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)

@property (nonatomic, getter=x, setter=setX:) CGFloat x;

@property (nonatomic, getter=y, setter=setY:) CGFloat y;

@property (nonatomic, getter=width, setter=setWidth:) CGFloat width;

@property (nonatomic, getter=height, setter=setHeight:) CGFloat height;

@end
