//
//  PlayerViewController.h
//  battleship
//
//  Created by Michael M. Mayer on 12/12/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamesListViewController.h"
#import "AttackViewController.h"
#import "GameRepo.h"
#import "ShipLayoutView.h"
#import "AttackResultsView.h"
#import "Player.h"
#import "Game.h"

@interface PlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet ShipLayoutView *overlay;
@property (weak, nonatomic) IBOutlet  AttackResultsView *attacksView;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet UILabel *opp1Label;
@property (weak, nonatomic) IBOutlet UILabel *opp2Label;
@property (weak, nonatomic) IBOutlet UILabel *opp3Label;
@property (weak, nonatomic) IBOutlet UILabel *opp4Label;
@property (nonatomic, weak) Game *currGame;

- (void)showAttacks:(id)recognizer;
- (UIView *)viewWithTag:(int)tag;
-(NSString *)resultString:(int)result;
- (IBAction)backButtonPressed:(id)sender;

@end
