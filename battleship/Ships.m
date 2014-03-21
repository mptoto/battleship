//
//  Ships.m
//  battleship
//
//  Created by Matthew Toto on 11/25/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "Ships.h"
#import "BBdefs.h"

@implementation Ships

- (id) init:(int)size
{
	self = [super init];
	if (self) {
		_length = size;
		self.start = CGPointZero;
		self.isVertical = NO;
		self.isPlaced = NO;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_length = [aDecoder decodeIntForKey:@"length"];
		self.start = [aDecoder decodeCGPointForKey:@"start"];
		self.isPlaced = [aDecoder decodeBoolForKey:@"isPlaced"];
		self.isVertical = [aDecoder decodeBoolForKey:@"isVertical"];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:(int)self.length forKey:@"length"];
	[aCoder encodeCGPoint:self.start forKey:@"start"];
	[aCoder encodeBool:self.isPlaced forKey:@"isPlaced"];
	[aCoder encodeBool:self.isVertical forKey:@"isVertical"];
}

- (BOOL)canShipBePlaced:(NSArray *)fleet {
	BOOL isShipValid = YES;
	//start is out of bounds
	if(self.start.x < 0 || self.start.x > NUMGRIDS-1 || self.start.y < 0 || self.start.y > NUMGRIDS-1)
		isShipValid = NO;
	
	//ship starts in bound but runs out of bounds
	else if((self.isVertical && self.start.y < self.length - 1) || (!self.isVertical && self.start.x > NUMGRIDS - self.length))
		isShipValid = NO;
	
	//ship overlaps any other ship in the fleet that has been placed
	else {
		for (Ships *aShip in fleet) {
			if (aShip.isPlaced &&  ![self isEqual:aShip] && doShipsIntersect(aShip.start.x, aShip.start.y, [aShip endX], [aShip endY], self.start.x, self.start.y, [self endX], [self endY])) {
				isShipValid = NO;
				break;
			}
		}
	}

	return isShipValid;
}

- (BOOL)isEqualToShip:(Ships *)ship {
	//Compares properties and uses safe compare for the BOOLs
	BOOL areEqual = YES;
	if (!ship)
		areEqual = NO;
	else
		areEqual = self.length == ship.length &&
		self.start.x == ship.start.x && self.start.y == ship.start.y &&
		((self.isPlaced && ship.isPlaced) || (!self.isPlaced && !ship.isPlaced)) &&
		((self.isVertical == ship.isVertical) || (!self.isVertical == !ship.isVertical));

	return areEqual;
}

- (BOOL)isEqual:(id)ship {
	BOOL areEqual;
	if (self == ship)
		areEqual = YES;
	else if (![ship isKindOfClass:[Ships class]])
		areEqual =  NO;
	else areEqual = [self isEqualToShip:(Ships *)ship];
	
	return areEqual;
}

- (NSUInteger)hash {
	//good enough for most initialized fleets
	return (unsigned)((self.start.y * NUMGRIDS + self.start.x) * self.length);
}

- (double)endX {
	return self.isVertical ? self.start.x : self.start.x + self.length - 1;
}

- (double)endY {
	return self.isVertical ? self.start.y - self.length + 1 : self.start.y;
}

// http://ptspts.blogspot.com/2010/06/how-to-determine-if-two-line-segments.html
// fast schoolbook algorithm for determining if two (finite) line segments on a 2D plane intersect (cross)
static bool IsOnSegment(double xi, double yi, double xj, double yj,
                        double xk, double yk) {
	return (xi <= xk || xj <= xk) && (xk <= xi || xk <= xj) &&
	(yi <= yk || yj <= yk) && (yk <= yi || yk <= yj);
}

static char ComputeDirection(double xi, double yi, double xj, double yj,
                             double xk, double yk) {
	double a = (xk - xi) * (yj - yi);
	double b = (xj - xi) * (yk - yi);
	return a < b ? -1 : a > b ? 1 : 0;
}

/** Do line segments (x1, y1)--(x2, y2) and (x3, y3)--(x4, y4) intersect? */
BOOL doShipsIntersect(double x1, double y1, double x2, double y2,
                             double x3, double y3, double x4, double y4) {
	char d1 = ComputeDirection(x3, y3, x4, y4, x1, y1);
	char d2 = ComputeDirection(x3, y3, x4, y4, x2, y2);
	char d3 = ComputeDirection(x1, y1, x2, y2, x3, y3);
	char d4 = ComputeDirection(x1, y1, x2, y2, x4, y4);
	
	return (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
			((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) ||
	(d1 == 0 && IsOnSegment(x3, y3, x4, y4, x1, y1)) ||
	(d2 == 0 && IsOnSegment(x3, y3, x4, y4, x2, y2)) ||
	(d3 == 0 && IsOnSegment(x1, y1, x2, y2, x3, y3)) ||
	(d4 == 0 && IsOnSegment(x1, y1, x2, y2, x4, y4));
}



@end
