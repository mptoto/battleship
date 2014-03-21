//
//  Opponent.m
//  battleship
//
//  Created by Michael Mayer on 3/9/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import "Opponent.h"
#import "Ships.h"

@implementation Opponent
CGPoint *moves;

- (id) init
{
	self = [super init];
	if(self) {
		self.turnNumber = 0;
		self.name = [NSString stringWithFormat:@"Bruce%d", arc4random_uniform(1000)];
		self.fleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
		self.moves = malloc(sizeof(CGPoint) * 100);
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
//	@property (nonatomic, copy) NSString *name;
//	@property (nonatomic, strong) NSArray *fleet;
//	@property CGPoint *moves;
//	@property int turnNumber;

	self = [super init];
	if (self) {
		self.turnNumber = [aDecoder decodeIntForKey:@"turnNumber"];
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.fleet = [aDecoder decodeObjectForKey:@"fleet"];
		self.moves = malloc(sizeof(CGPoint) * 100);
		[aDecoder decodeArrayOfObjCType:@encode(CGPoint) count:self.turnNumber at:self.moves];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:self.turnNumber forKey:@"turnNumber"];
	[aCoder encodeObject:self.name forKey:@"name"];
	[aCoder encodeObject:self.fleet forKey:@"fleet"];
	[aCoder encodeArrayOfObjCType:@encode(CGPoint) count:self.turnNumber at:self.moves];	
}


-(CGPoint)newMove
// adds newMove to current turnNumber (does not change turnNumber)
{
	CGPoint move;
	BOOL moveFound = NO;
	while (!moveFound) {
		move = CGPointMake(arc4random_uniform(NUMGRIDS), arc4random_uniform(NUMGRIDS));
		moveFound = YES;
		for (int i = 0; i < self.turnNumber; i++) {
			CGPoint prevMove = self.moves[i];
			if(move.x == prevMove.x && move.y == prevMove.y) {
				moveFound = NO;
				break; //for
			}
				
		}
		if (moveFound)
			self.moves[self.turnNumber] = move;
	}
	return move;
}
@end
