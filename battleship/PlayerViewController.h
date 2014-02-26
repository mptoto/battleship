//
//  PlayerViewController.h
//  battleship
//
//  Created by Matthew Toto on 12/12/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamesListViewController.h"
#import "ViewController.h"
#import "GameRepo.h"
#import "ShipLayoutView.h"

@interface PlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet ShipLayoutView *overlay;
@property (nonatomic, weak) Game *currGame;
- (IBAction)backButtonPressed:(id)sender;

@end
