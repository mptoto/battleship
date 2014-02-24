//
//  Ships.m
//  battleship
//
//  Created by Matthew Toto on 11/25/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "Ships.h"

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


@end
