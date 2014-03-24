//
//  Game.h
//  battleship
//
//  Created by Michael M. Mayer on 11/27/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ships.h"
#import "Opponent.h"

@interface Game : NSObject <NSCoding>

@property (nonatomic, copy) NSString *playerName;
@property int turnNumber;
@property BOOL isMyMove;
@property NSTimeInterval timeLeft;
@property (nonatomic, strong) NSDate *turnStartTime;
@property (nonatomic, strong) NSString *boardMap;
@property (nonatomic, strong) NSArray *myFleet;
@property (nonatomic, strong) NSArray *myMoves;
@property (nonatomic, strong) NSArray *opponents;


- (instancetype) init;

@end
