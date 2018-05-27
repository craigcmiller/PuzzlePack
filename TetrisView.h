#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreGraphics/CGContext.h>

#import "Board.h"

@interface TetrisView : UIView {
	@private
	Board *board;
	NSTimer *updateTimer;
	int blockWidth;
	int blockHeight;
	id __weak appDelegate;
}

- (void)startNewGameWithBoardWidth:(int)width height:(int)height;

- (IBAction)fastDown;

- (IBAction)moveLeft;

- (IBAction)moveRight;

- (IBAction)rotate;

- (IBAction)endGame;

@property(readonly) Board *board;

@property(weak) id appDelegate;

@end
