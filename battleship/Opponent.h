//
//  Opponent.h
//  battleship
//
//  Created by Michael Mayer on 3/9/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBdefs.h"

@interface Opponent : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *fleet;
@property CGPoint *moves;
@property int turnNumber;

-(id) init;
- (CGPoint) newMove;
@end
