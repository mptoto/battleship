//
//  PlayerViewController.m
//  battleship
//
//  Created by Matthew Toto on 12/12/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "PlayerViewController.h"

@implementation PlayerViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
	//[self setTitle:[current opponentNames][0]];

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
