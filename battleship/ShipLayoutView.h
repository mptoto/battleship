//
//  ShipLayoutView.h
//  battleship
//
//  Created by Michael Mayer on 2/10/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"
#import "GameRepo.h"
#import "AppDelegate.h"
#import "BBdefs.h"

@class ShipPaletteView;

@interface ShipLayoutView : UIView
@property (nonatomic, weak) NSArray *theShips;

-(void) drawShips:(CGSize)gridSize;
void drawShip(unsigned long length, CGSize gridSize, BOOL isVertical, BOOL filled, UIColor *shipColor);
@end
