//
//  Opponent.h
//  battleship
//
//  Created by Michael M. Mayer on 3/9/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBdefs.h"

@interface Opponent : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *fleet;
@property CGPoint *moves;
@property int turnNumber;

-(instancetype) init;
- (CGPoint) generateMove;
@end
