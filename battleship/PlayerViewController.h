//
//  PlayerViewController.h
//  battleship
//
//  Created by Michael M. Mayer on 12/12/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamesListViewController.h"
#import "ViewController.h"
#import "GameRepo.h"
#import "ShipLayoutView.h"
#import "AttacksByOpponentsView.h"

@interface PlayerViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet ShipLayoutView *overlay;
@property (weak, nonatomic) IBOutlet  AttacksByOpponentsView *attacksView;
@property (nonatomic, weak) Game *currGame;
@property (weak, nonatomic) IBOutlet UILabel *CoordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet UILabel *Opp1Label;
@property (weak, nonatomic) IBOutlet UILabel *Opp2Label;
@property (weak, nonatomic) IBOutlet UILabel *Opp3Label;
@property (weak, nonatomic) IBOutlet UILabel *Opp4Label;

- (void)showAttacks:(id)recognizer;
- (IBAction)backButtonPressed:(id)sender;

@end
