//
//  Ship.h
//  battleship
//
//  Created by Michael M. Mayer on 11/25/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ship : NSObject <NSCoding>

@property (readonly) unsigned long length;
@property CGPoint start;
@property BOOL isPlaced;
@property BOOL isVertical;

-(instancetype) init:(int)size;
- (BOOL)canShipBePlaced:(NSArray *)fleet;
-(BOOL)isHit:(CGPoint)attack;

@end
