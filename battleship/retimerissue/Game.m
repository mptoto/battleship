//
//  GameStates.m
//  battleship
//
//  Created by Michael M. Mayer on 11/27/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "Game.h"

@implementation Game


- (instancetype)init {
	self = [super init];
	if (self) {
		self.playerName = @"Todd";
		self.turnNumber = 0;
		self.isMyMove = YES;
		self.timeLeft = 24.0 * 60.0 * 60.0; //number of seconds in a day
		self.turnStartTime = [[NSDate alloc] init]; //initialized to current date and time
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		_myFleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		self.playerName = [aDecoder decodeObjectForKey:@"playerName"];
		self.turnNumber = [aDecoder decodeIntForKey:@"turnNumber"];
		self.isMyMove = [aDecoder decodeBoolForKey:@"isMyMove"];
		self.timeLeft = [aDecoder decodeDoubleForKey:@"timeLeft"];
		self.turnStartTime = [aDecoder decodeObjectForKey:@"turnStartTime"];
		_myFleet = [aDecoder decodeObjectForKey:@"myFleet"];
		
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		//TODO
		//myMoves;
		//opponents
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.playerName forKey:@"playerName"];
	[aCoder encodeInt:self.turnNumber forKey:@"turnNumber"];
	[aCoder encodeBool:self.isMyMove forKey:@"isMyMove"];
	[aCoder encodeDouble:self.timeLeft forKey:@"timeLeft"];
	[aCoder encodeObject:self.turnStartTime forKey:@"turnStartTime"];
	[aCoder encodeObject:self.myFleet forKey:@"myFleet"];
	//TODO
	//myMoves;
	//opponents

}

- (void)generateTurn
{
	for (Opponent *opp in self.opponents) {
		[opp generateMove];
		opp.turnNumber++;
	}
	self.turnNumber++;
	self.isMyMove = YES;
}

@end