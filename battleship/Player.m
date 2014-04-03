//
//  Player.m
//  battleship
//
//  Created by Michael M. Mayer on 3/9/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import "Player.h"
#import "Ship.h"

@implementation Player

- (instancetype) initWithName:(NSString *)name
{
	self = [super init];
	if(self) {
		self.name = name;
		self.fleet = @[[[Ship alloc] init:2], [[Ship alloc] init:3], [[Ship alloc] init:3], [[Ship alloc] init:4], [[Ship alloc] init:5]];
		self.moves = malloc(sizeof(CGPoint) * MAXMOVES);
	}
	return self;
}

- (instancetype) init
{
	return [self initWithName:[NSString stringWithFormat:@"Bruce%d", arc4random_uniform(1000)]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
//	@property (nonatomic, copy) NSString *name;
//	@property (nonatomic, strong) NSArray *fleet;
//	@property CGPoint *moves;

	self = [super init];
	if (self) {
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.fleet = [aDecoder decodeObjectForKey:@"fleet"];
		self.moves = malloc(sizeof(CGPoint) * MAXMOVES);
		NSMutableArray *pointArray = [aDecoder decodeObjectForKey:@"moves"];
		for (int i = 0; i < MAXMOVES; i++) {
			self.moves[i] = [[pointArray objectAtIndex:i] CGPointValue];
			[pointArray addObject:[NSValue valueWithCGPoint:self.moves[i]]];
		}
		//[aDecoder decodeArrayOfObjCType:@encode(typeof(CGPoint)) count:MAXMOVES at:self.moves];

	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.name forKey:@"name"];
	[aCoder encodeObject:self.fleet forKey:@"fleet"];
	NSMutableArray *pointArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < MAXMOVES; i++) {
		[pointArray addObject:[NSValue valueWithCGPoint:self.moves[i]]];
	}
	[aCoder encodeObject:pointArray forKey:@"moves"];
	//	[aCoder encodeArrayOfObjCType:@encode(typeof(CGPoint)) count:MAXMOVES at:self.moves];
}

- (void)dealloc {
	NSLog(@"Player deallocated: %@", self);
	free(_moves);
	_moves = NULL;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@", self.name];
}

-(CGPoint)generateMove:(int)turnNumber
// adds newMove to current turnNumber (does not change turnNumber)
{
	CGPoint move;
	BOOL moveFound = NO;
	while (!moveFound) {
		move = CGPointMake(arc4random_uniform(NUMGRIDS), arc4random_uniform(NUMGRIDS));
		moveFound = YES;
		for (int i = 0; i < turnNumber; i++) {
			CGPoint previousMove = self.moves[i];
			if(move.x == previousMove.x && move.y == previousMove.y) {
				moveFound = NO;
				break; //for
			}
			
		}
		if (moveFound)
			self.moves[turnNumber] = move;
	}
	return move;
}

- (void)generateFleet
{
	for(Ship *possShip in self.fleet) {
		do {
			possShip.start = CGPointMake(arc4random_uniform(NUMGRIDS), arc4random_uniform(NUMGRIDS));
			possShip.isVertical = arc4random_uniform(2);
		} while (![possShip canShipBePlaced:self.fleet]);
		possShip.isPlaced = YES;
	}
}


@end
