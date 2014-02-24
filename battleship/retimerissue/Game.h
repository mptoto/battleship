//
//  Game.h
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ships.h"

@interface Game : NSObject <NSCoding>

@property int turnNumber;
@property BOOL isMyMove;
@property NSTimeInterval timeLeft;
@property (nonatomic, strong) NSDate *turnStartTime;
@property (nonatomic, strong) NSString *boardMap;
@property (nonatomic, strong) NSArray *opponentNames;
@property (nonatomic, strong) NSArray *myfleet;
@property (nonatomic, strong) NSArray *myMoves;
@property (nonatomic, strong) NSArray *opponentShipLocations;
@property (nonatomic, strong) NSArray *oppMoves;


- init;


@end
