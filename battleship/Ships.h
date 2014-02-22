//
//  Ships.h
//  battleship
//
//  Created by Matthew Toto on 11/25/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUMSHIPS 5

@interface Ships : NSObject

@property (readonly) unsigned long length;
@property CGPoint start;
@property BOOL isPlaced;
@property BOOL isVertical;

-(id) init:(int)size;


@end
