//
//  GameStates.m
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "Game.h"

@implementation Game


- (id)init {
	self = [super init];
	if (self) {
		self.turnNumber = 0;
		self.isMyMove = YES;
		self.timeLeft = 24.0 * 60.0 * 60.0; //number of seconds in a day
		self.turnStartTime = [[NSDate alloc] init]; //initialized to current date and time
		[self setOpponentNames:@[@"Todd"]];
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		_myFleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
		
		//myMoves;
		//opponentShipLocations;
		//opponentMoves;
		
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		self.turnNumber = [aDecoder decodeIntForKey:@"turnNumber"];
		self.isMyMove = [aDecoder decodeBoolForKey:@"isMyMove"];
		self.timeLeft = [aDecoder decodeDoubleForKey:@"timeLeft"];
		self.turnStartTime = [aDecoder decodeObjectForKey:@"turnStartTime"];
		_myFleet = [aDecoder decodeObjectForKey:@"myFleet"];
		
		[self setOpponentNames:@[@"Todd"]];
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		
		//myMoves;
		//opponentShipLocations;
		//opponentMoves;
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:self.turnNumber forKey:@"turnNumber"];
	[aCoder encodeBool:self.isMyMove forKey:@"isMyMove"];
	[aCoder encodeDouble:self.timeLeft forKey:@"timeLeft"];
	[aCoder encodeObject:self.turnStartTime forKey:@"turnStartTime"];
	[aCoder encodeObject:self.myFleet forKey:@"myFleet"];
	
	//[self setOpponentNames:@[@"Todd"]];
	//[self setBoardMap:@"satelite_ocean_view_2.jpg"];
	//myMoves;
	//opponentShipLocations;
	//opponentMoves;

}

@end