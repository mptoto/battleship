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

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:@"Opponents' Status"];
    self.pegView.image = [UIImage imageNamed:@"sniper target.png"];
	[self.pegView setHidden:YES];
	[self.fireButton setHidden:YES];
	[self.turnLabel setText:[NSString stringWithFormat:@"Current Turn:%d", self.currGame.turnNumber]];
	[self.coordinatesLabel setText:@"Coordinates:"];
	[self.opp1Label setText:@""];
	[self.opp2Label setText:@""];
	[self.opp3Label setText:@""];
	[self.opp4Label setText:@""];
	int *results = calloc(MAXMOVES, sizeof(int));

	CGPoint *localMoves = [self.currGame.players[LOCALPLAYER] moves];
	NSMutableSet *allOppAtacks = [NSMutableSet set];
	for (int i = 0; i < self.currGame.turnNumber; i++) {
		int gridIndex = (int)localMoves[i].y * NUMGRIDS + (int)localMoves[i].x;
		BOOL skippedLocalPlayer = NO;
		for (Player *opp in self.currGame.players) {
			if (!skippedLocalPlayer) {
				skippedLocalPlayer = YES;
			}
			else {
				for (Ship *aShip in opp.fleet) {
					if ([aShip isHit:localMoves[i]] && ![allOppAtacks containsObject:[NSValue valueWithCGPoint:localMoves[i]]]) {
						results[gridIndex] = HIT;
					}
					else if (results[gridIndex] != HIT) {
						results[gridIndex] = MISS;
					}
				}
				[allOppAtacks addObject:[NSValue valueWithCGPoint:opp.moves[i]]];
			}
		}
	}
	if(self.attackView.results)
		free(self.attackView.results);
	self.attackView.results = results;
	
	UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firePressed:)];
	[doubleTapRecognizer setNumberOfTapsRequired:2];
	[self.attackView addGestureRecognizer:doubleTapRecognizer];
}

-(IBAction)showAttackLocation:(UITapGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:self.attackView];
	location.x =(int)floorf(location.x / (self.attackView.bounds.size.width / NUMGRIDS));
	location.y=(int)floorf(location.y / (self.attackView.bounds.size.height / NUMGRIDS));
    [self.coordinatesLabel setText:[NSString stringWithFormat:@"Coordinates:%c%d", XLEGEND[(int)location.x], (int)location.y]];
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
		[self drawImageAtAttackPoint:location];
		[self.pegView setHidden:NO];
		[self.fireButton setHidden:NO];
		[self.view setNeedsDisplay];
	}
	else {
		//TODO - Show results of previous attacks
	}
}

-(void)drawImageAtAttackPoint:(CGPoint)location
{
	//Draw attack image on board where it's touched
	CGFloat centerX = (int)location.x * (int)(self.attackView.bounds.size.width / NUMGRIDS) + (int)(self.attackView.bounds.size.width / (NUMGRIDS * 2));
	CGFloat centerY = (int)location.y * (int)(self.attackView.bounds.size.height / NUMGRIDS) + (int)(self.attackView.bounds.size.height / (NUMGRIDS * 2));
	//Update Info for opps being attacked
	//Draw the peg
    self.pegView.center = CGPointMake(centerX, centerY);
    self.pegView.alpha = 1.0;
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
	[self viewWillAppear:YES];
	[self.attackView setNeedsDisplay];
}

@end
