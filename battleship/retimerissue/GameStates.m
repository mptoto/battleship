//
//  GameStates.m
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "GameStates.h"
#import "Ships.h"

@implementation GameStates


- (id)init {
	self = [super init];
	if (self) {
		_turnNumber = 0;
		_whosTurn = YES;
		_timeLeft = 24.0 * 60.0 * 60.0; //number of seconds in a day
		_turnStartTime = [[NSDate alloc] init]; //initialized to current date and time
		[self setOpponentName:@"Todd"];
		[self setBoardMap:@"satelite_ocean_view_2.jpg"];
		_myfleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
		
		//pegLocations;
		//opponentShipLocations;
		//opponentPegLocations;
		
	}
	return self;
}

@end