//
//  Cell.h
//  MiniTetris
//
//  Created by Craig Miller on 08/03/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CellStateValue) { CellStateEmpty=0, CellStateSet=1 };

@interface BoardCell : NSObject {
	@private
	CellStateValue cellState;
	float red, green, blue;
}

/**
 * Construct a cell
 * @param cellState
 */
- (instancetype)initWithState:(CellStateValue)state NS_DESIGNATED_INITIALIZER;

/**
 * Take the properties of another cell
 * @param c
 */
- (void)copyPropertiesFromCell:(BoardCell *)c;

/**
 * Return a character representation of this cell
 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *toString;

/**
 * Get the state of the cell
 */
@property(readwrite) CellStateValue cellState;

@property(readwrite) float red;
@property(readwrite) float green;
@property(readwrite) float blue;

@end
