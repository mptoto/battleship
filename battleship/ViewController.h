//
//  ViewController.h
//  battleship
//
//  Created by Matthew Toto on 11/24/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ships.h"
#import "GameRepo.h"
#import "GamesListViewController.h"
#import "PlayerViewController.h"
#import "ShipLayoutView.h"
#import "ShipPaletteView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *boardImage;
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UILabel *CoordinatesSelectedField;
@property (weak, nonatomic) IBOutlet UIImageView *pegView;

@property (nonatomic, weak) Game *currGame;

- (IBAction)firePressed:(id)sender;

//- (IBAction)colorPressed:(id)sender;

@end
