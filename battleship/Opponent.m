//
//  Opponent.m
//  battleship
//
//  Created by Michael M. Mayer on 3/9/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import "Opponent.h"
#import "Ships.h"

@implementation Opponent

- (instancetype) init
{
	self = [super init];
	if(self) {
		self.turnNumber = 0;
		self.name = [NSString stringWithFormat:@"Bruce%d", arc4random_uniform(1000)];
		self.fleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
		[self generateFleet];
		self.moves = malloc(sizeof(CGPoint) * 100);
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
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

- (void)generateFleet
{
	for(Ships *possShip in self.fleet) {
		do {
			possShip.start = CGPointMake(arc4random_uniform(NUMGRIDS), arc4random_uniform(NUMGRIDS));
			possShip.isVertical = arc4random_uniform(2);
		} while (![possShip canShipBePlaced:self.fleet]);
		possShip.isPlaced = YES;
	}
}

-(CGPoint)generateMove
// adds newMove to current turnNumber (does not change turnNumber)
{
	CGPoint move;
	BOOL moveFound = NO;
	while (!moveFound) {
		move = CGPointMake(arc4random_uniform(NUMGRIDS), arc4random_uniform(NUMGRIDS));
		moveFound = YES;
		for (int i = 0; i < self.turnNumber; i++) {
			CGPoint previousMove = self.moves[i];
			if(move.x == previousMove.x && move.y == previousMove.y) {
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
