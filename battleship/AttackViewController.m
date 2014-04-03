//
//  ViewController.m
//  battleship
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "AttackViewController.h"


@implementation AttackViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayerViewController *destVC = [segue destinationViewController];
	destVC.currGame = self.currGame;
    [destVC setTitle:@"Player's Status"];
}

- (void)viewDidLoad
{
    [self setTitle:@"Opponents' Status"];
    self.pegView.image = [UIImage imageNamed:@"circle_white_15x15.png"];
	[self.pegView setHidden:YES];
	[self.fireButton setHidden:YES];
	[self.turnLabel setText:[NSString stringWithFormat:@"%d", self.currGame.turnNumber]];
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:@"Opponents' Status"];
    self.pegView.image = [UIImage imageNamed:@"circle_white_15x15.png"];
	[self.pegView setHidden:YES];
	[self.fireButton setHidden:YES];
	[self.turnLabel setText:[NSString stringWithFormat:@"%d", self.currGame.turnNumber]];
}

-(IBAction)showAttackLocation:(UITapGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:self.attackView];
	location.x =(int)floorf(location.x / (self.attackView.bounds.size.width / NUMGRIDS));
	location.y=(int)floorf(location.y / (self.attackView.bounds.size.height / NUMGRIDS));
    [self.coordinatesLabel setText:[NSString stringWithFormat:@"%c%d", XLEGEND[(int)location.x], (int)location.y]];
	BOOL isValidAttack = YES;
	CGPoint *currMoves = [self.currGame.players[0] moves];
	for (int i = 0; i < self.currGame.turnNumber; i++) {
		if (CGPointEqualToPoint(location, currMoves[i])) {
			isValidAttack = NO;
			break;
		}
	}
	if(isValidAttack) {
		self.attackLocation = location;
		CGFloat modX = (int)location.x * (int)(self.attackView.bounds.size.width / NUMGRIDS) + (int)(self.attackView.bounds.size.width / (NUMGRIDS * 2));
		CGFloat modY = (int)location.y * (int)(self.attackView.bounds.size.height / NUMGRIDS) + (int)(self.attackView.bounds.size.height / (NUMGRIDS * 2));
		//Update Info for opps being attacked
		//Draw the peg
		[self drawImageAtAttackPoint:CGPointMake(modX, modY)];
		[self.fireButton setHidden:NO];
	}
	else {
		//TODO - At this time, do nothing if attack is not a vaild move
	}
}

-(void)drawImageAtAttackPoint:(CGPoint)centerPoint {
	//Draw attack image on board where it's touched
    CGPoint convertedPoint = [[self view] convertPoint:centerPoint fromView:self.boardImage];
    self.pegView.center = convertedPoint;
    self.pegView.alpha = 1.0;
	[self.pegView setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firePressed:(id)sender {
	[self.currGame.players[LOCALPLAYER] moves][self.currGame.turnNumber] = self.attackLocation;
    UIAlertView *fireAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"You have fired!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [fireAlert show];
	self.currGame.isMyMove = NO;
	[self.currGame generateTurn];
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
