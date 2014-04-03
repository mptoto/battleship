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
		self.turnNumber = 0;
		self.isMyMove = YES;
		self.timeLeft = 24.0 * 60.0 * 60.0; //number of seconds in a day
		self.turnStartTime = [[NSDate alloc] init]; //initialized to current date and time
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		self.players = [[NSMutableArray alloc]init];
		[self.players addObject:[[Player alloc] init]];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
//	@property int turnNumber;
//	@property BOOL isMyMove;
//	@property NSTimeInterval timeLeft;
//	@property (nonatomic, strong) NSDate *turnStartTime;
//	@property (nonatomic, strong) NSString *boardMap;
//	@property (nonatomic, strong) NSArray *players;
	self = [super init];
	if (self) {
		self.turnNumber = [aDecoder decodeIntForKey:@"turnNumber"];
		self.isMyMove = [aDecoder decodeBoolForKey:@"isMyMove"];
		self.timeLeft = [aDecoder decodeDoubleForKey:@"timeLeft"];
		self.turnStartTime = [aDecoder decodeObjectForKey:@"turnStartTime"];
		self.players = [aDecoder decodeObjectForKey:@"players"];
		
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:self.turnNumber forKey:@"turnNumber"];
	[aCoder encodeBool:self.isMyMove forKey:@"isMyMove"];
	[aCoder encodeDouble:self.timeLeft forKey:@"timeLeft"];
	[aCoder encodeObject:self.turnStartTime forKey:@"turnStartTime"];
	[aCoder encodeObject:self.players forKey:@"players"];
}

- (void)generateTurn
// called when the user has made their turn, generates opponents moves and increments turn counter
// used when not working with a game server and the opps are all artificial
{
	for (Player *opp in self.players) {
		if ([self.players indexOfObject:opp] != LOCALPLAYER) {
			[opp generateMove:self.turnNumber];
		}
	}
	self.turnNumber++;
	self.isMyMove = YES;
}

@end