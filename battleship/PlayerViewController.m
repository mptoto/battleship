//
//  PlayerViewController.m
//  battleship
//
//  Created by Michael M. Mayer on 12/12/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "PlayerViewController.h"
#import "BBdefs.h"

@implementation PlayerViewController;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.overlay.theShips = self.currGame.myFleet;
	self.attacksView.opponents = self.currGame.opponents;
	[self setTitle:@"Player's Status"];
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAttacks:)];
	[self.attacksView addGestureRecognizer:tapRecognizer];

}

- (void)showAttacks:(id)recognizer
{
    CGPoint location = [recognizer locationInView:self.overlay];
    [self.CoordinatesLabel setText:[NSString stringWithFormat:@"%.2lf, %.2lf", location.x, location.y]];

	location.x =(int)floorf(location.x / (self.overlay.bounds.size.width / NUMGRIDS));
	location.y=(int)floorf(location.y / (self.overlay.bounds.size.height / NUMGRIDS));
	
    [self.Opp1Label setText:[NSString stringWithFormat:@"%.2lf, %.2lf", location.x, location.y]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
