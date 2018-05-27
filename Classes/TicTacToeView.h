//
//  TicTacToeView.h
//  Touchtris
//
//  Created by Craig Miller on 29/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreGraphics/CoreGraphics.h>
#import <CoreGraphics/CGContext.h>

#import "TicTacToe.h"


@interface TicTacToeView : UIView {
	@private
	TicTacToe *board;
	UILabel *statusField;
}

- (void)newGame:(NSInteger)side textField:(UILabel *)statusTextField;

@end
