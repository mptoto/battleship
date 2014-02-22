//
//  GameStates.h
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStates : NSObject

@property int turnNumber;
@property BOOL whosTurn;
@property NSTimeInterval timeLeft;
@property (nonatomic, strong) NSDate *turnStartTime;
@property (nonatomic, strong) NSString *boardMap;
@property (nonatomic, strong) NSString *opponentName;
@property (nonatomic, strong) NSArray *myfleet;
@property (nonatomic, strong) NSArray *pegLocations;
@property (nonatomic, strong) NSArray *opponentShipLocations;
@property (nonatomic, strong) NSArray *opponentPegLocations;

//@property (nonatomic, strong) NSMutableArray *oldGames;

- init;


@end
