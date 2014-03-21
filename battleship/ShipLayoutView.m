//
//  ShipLayoutView.m
//  battleship
//
//  Created by Michael Mayer on 2/10/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import "ShipLayoutView.h"
#import "ShipPaletteView.h"

@implementation ShipLayoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		//
	}
    return self;
}

- (void) awakeFromNib {
	//
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef cref = UIGraphicsGetCurrentContext();
	//	CGPoint center = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0, self.bounds.origin.y + self.bounds.size.height / 2.0);
	CGSize gridSize = CGSizeMake(self.bounds.size.width / NUMGRIDS, self.bounds.size.height / NUMGRIDS);

	// Draw grid
	CGContextSaveGState(cref);
	[[UIColor greenColor] setStroke];
	CGContextSetLineWidth(cref, 1.0);
	for (int i = 1; i < NUMGRIDS; i++) {
		CGContextMoveToPoint(cref, 0 , gridSize.height * i);
		CGContextAddLineToPoint(cref, self.bounds.size.width, gridSize.height * i);
	}
	for (int i = 1; i < NUMGRIDS; i++) {
		CGContextMoveToPoint(cref, gridSize.width * i , 0.0);
		CGContextAddLineToPoint(cref, gridSize.width * i, self.bounds.size.height);
	}
	CGContextStrokePath(cref);
	
	[self drawShips:gridSize];
	CGContextRestoreGState(cref);
}

- (void) drawShips:(CGSize)gridSize
{
	CGContextRef cref = UIGraphicsGetCurrentContext();
	for (Ships *aShip in self.theShips) {
		if (aShip.isPlaced) {
			CGContextSaveGState(cref);
			CGContextMoveToPoint(cref, aShip.start.x * gridSize.width + gridSize.width * 0.05, (aShip.start.y + 1) * gridSize.height - gridSize.height * 0.05);
			drawShip(aShip.length, gridSize, aShip.isVertical, YES, [UIColor orangeColor]);
			CGContextRestoreGState(cref);
		}
	}
}

@end

void drawShip(unsigned long length, CGSize gridSize, BOOL isVertical, BOOL filled, UIColor *shipColor)
{
	CGContextRef cref = UIGraphicsGetCurrentContext();
	CGPoint startPoint = CGContextGetPathCurrentPoint(cref);
	CGSize insetGridSize = CGSizeMake(gridSize.width*0.9, gridSize.height*0.9);
	
	CGContextSaveGState(cref);
	filled ? [shipColor setFill] : [shipColor setStroke];
	if (!isVertical) {
		CGContextAddLineToPoint(cref, insetGridSize.width * length / 2.0 + startPoint.x, startPoint.y);
		CGContextAddQuadCurveToPoint(cref, insetGridSize.width * length + startPoint.x - insetGridSize.width, startPoint.y, insetGridSize.width * length + startPoint.x, startPoint.y - insetGridSize.height / 2.0);
		CGContextAddQuadCurveToPoint(cref, insetGridSize.width * length + startPoint.x - insetGridSize.width, startPoint.y - insetGridSize.height, insetGridSize.width * length / 2.0 + startPoint.x, startPoint.y - insetGridSize.height);
		CGContextAddLineToPoint(cref, startPoint.x, startPoint.y - insetGridSize.height);
		CGContextAddLineToPoint(cref, startPoint.x, startPoint.y);
	}
	else {
		CGContextAddLineToPoint(cref, startPoint.x, startPoint.y - insetGridSize.height * length / 2.0);
		CGContextAddQuadCurveToPoint(cref, startPoint.x, startPoint.y - insetGridSize.height * length + insetGridSize.height, startPoint.x + insetGridSize.width / 2.0, startPoint.y - insetGridSize.height * length);
		CGContextAddQuadCurveToPoint(cref, startPoint.x + insetGridSize.width, startPoint.y - insetGridSize.height * length + insetGridSize.height, startPoint.x + insetGridSize.width, startPoint.y - insetGridSize.height * length / 2.0);
		CGContextAddLineToPoint(cref, startPoint.x + insetGridSize.width, startPoint.y);
		CGContextAddLineToPoint(cref, startPoint.x, startPoint.y);
	}
	filled ? CGContextFillPath(cref) : CGContextStrokePath(cref);
	CGContextRestoreGState(cref);
}


