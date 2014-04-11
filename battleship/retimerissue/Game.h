//
//  Game.h
//  battleship
//
//  Created by Michael M. Mayer on 11/27/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ship.h"
#import "Player.h"

@interface Game : NSObject <NSCoding>

@property int turnNumber;
@property BOOL isMyMove;
@property NSTimeInterval timeLeft;
@property (nonatomic, strong) NSDate *turnStartTime;
@property (nonatomic, strong) NSString *boardMap;
@property (nonatomic, strong) NSMutableArray *players;

- (instancetype) init;
- (void)generateTurn;

@end
