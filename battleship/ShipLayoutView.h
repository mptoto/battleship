//
//  ShipLayoutView.h
//  battleship
//
//  Created by Michael Mayer on 2/10/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ships.h"
#import "GameRepo.h"
#import "AppDelegate.h"

@class ShipPaletteView;

#define NUMGRIDS 10.0
#define GRIDSIZE 32.0

@interface ShipLayoutView : UIView
@property (nonatomic, weak) NSArray *theShips;

-(void) drawShips:(CGSize)gridSize;
void drawShip(unsigned long length, CGSize gridSize, BOOL isVertical, BOOL filled, UIColor *shipColor);
@end
