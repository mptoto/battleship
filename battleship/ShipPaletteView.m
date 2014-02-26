//
//  ShipPaletteView.m
//  battleship
//
//  Created by Michael Mayer on 2/11/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import "ShipPaletteView.h"

@implementation ShipPaletteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

	}
    return self;
}

- (void) awakeFromNib {
	for (UIButton *check in [self subviews]) {
		[check setHidden:YES];
	}
	//
}

- (void)drawRect:(CGRect)rect
{
	
	for (UIButton *aButton in self.subviews) {
		[self.theShips[aButton.tag] isPlaced] ? [aButton setHidden:NO] : [aButton setHidden:YES];
	}
	CGSize gridSize = CGSizeMake(24.0, 24.0);
	CGContextRef cref = UIGraphicsGetCurrentContext();
	CGContextSaveGState(cref);
	CGContextSetLineWidth(cref, 1.0);
	CGContextMoveToPoint(cref, 48, 32);
	drawShip([self.theShips[0] length], gridSize, NO, ![self.theShips[0] isPlaced], [UIColor blueColor]);
	
	CGContextMoveToPoint(cref, 176, 32);
	drawShip([self.theShips[1] length], gridSize, NO, ![self.theShips[1] isPlaced], [UIColor blueColor]);

	CGContextMoveToPoint(cref, 48, 64);
	drawShip([self.theShips[2] length], gridSize, NO, ![self.theShips[2] isPlaced], [UIColor blueColor]);

	CGContextMoveToPoint(cref, 176, 64);
	drawShip([self.theShips[3] length], gridSize, NO, ![self.theShips[3] isPlaced], [UIColor blueColor]);

	CGContextMoveToPoint(cref, 48, 96);
	drawShip([self.theShips[4] length], gridSize, NO, ![self.theShips[4] isPlaced], [UIColor blueColor]);

	CGContextRestoreGState(cref);
}


@end
