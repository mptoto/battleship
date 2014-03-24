//
//  ViewController.h
//  battleship
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ships.h"
#import "Game.h"
#import "GameRepo.h"
#import "GamesListViewController.h"
#import "PlayerViewController.h"
#import "ShipLayoutView.h"
#import "ShipPaletteView.h"

@interface PlaceShipsViewController : UIViewController

@property (weak, nonatomic) IBOutlet ShipLayoutView *overlayView;
@property (weak, nonatomic) IBOutlet ShipPaletteView *paletteView;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint currLoc;
@property (nonatomic, weak) Game *currGame;

-(IBAction)startGame:(id)sender;
-(IBAction)cancelGame:(id)sender;
-(void) placeShip:(UIPanGestureRecognizer *)recognizer;

@end
