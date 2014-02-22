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

@end
