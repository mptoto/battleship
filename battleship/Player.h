//
//  Player.h
//  battleship
//
//  Created by Michael M. Mayer on 3/9/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBdefs.h"

@interface Player : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *fleet;
@property CGPoint *moves;

- (instancetype) initWithName:(NSString *)name;
-(CGPoint)generateMove:(int)turnNumber;
- (void)generateFleet;

@end
