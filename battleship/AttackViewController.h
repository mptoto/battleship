//
//  AttackViewController.h
//  battleship
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"
#import "GameRepo.h"
#import "GamesListViewController.h"
#import "PlayerViewController.h"
#import "ShipLayoutView.h"
#import "ShipPaletteView.h"
#import "AttackResultsView.h"


@interface AttackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *boardImage;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet UILabel *opp1Label;
@property (weak, nonatomic) IBOutlet UILabel *opp2Label;
@property (weak, nonatomic) IBOutlet UILabel *opp3Label;
@property (weak, nonatomic) IBOutlet UILabel *opp4Label;
@property (weak, nonatomic) IBOutlet UIButton *fireButton;
@property (weak, nonatomic) IBOutlet UIImageView *pegView;
@property (nonatomic, weak) IBOutlet AttackResultsView *attackView;
@property (nonatomic, weak) Game *currGame;
@property (nonatomic) CGPoint attackLocation;

-(IBAction)showAttackLocation:(UITapGestureRecognizer *)recognizer;
-(IBAction)firePressed:(id)sender;
-(void)drawImageAtAttackPoint:(CGPoint)location;

@end
