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

- (void)viewWillAppear:(BOOL)animated
{
	self.overlay.theShips = [self.currGame.players[LOCALPLAYER] fleet];
	[self.turnLabel setText:[NSString stringWithFormat:@"Current Turn:%d", self.currGame.turnNumber]];
	[self.coordinatesLabel setText:@"Coordinates:"];
	[self.opp1Label setText:@""];
	[self.opp2Label setText:@""];
	[self.opp3Label setText:@""];
	[self.opp4Label setText:@""];

	int *results = calloc(MAXMOVES, sizeof(int));

	BOOL skippedLocalPlayer = NO;
	for (Player *opp in self.currGame.players) {
		if (!skippedLocalPlayer) {
			skippedLocalPlayer = YES;
		}
		else {
			for (int i = 0; i < self.currGame.turnNumber; i++) {
				int index = (int)opp.moves[i].y * NUMGRIDS + (int)opp.moves[i].x;
				for (Ship *aShip in [self.currGame.players[LOCALPLAYER] fleet]) {
					if ([aShip isHit:opp.moves[i]]) {
						results[index] = HIT;
					}
					else if (results[index] != HIT) {
						results[index] = MISS;
					}
				}
			}
		}
		
	}
	if(self.attacksView.results)
		free(self.attacksView.results);
	self.attacksView.results = results;
	[self setTitle:@"Player's Status"];
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAttacks:)];
	[self.attacksView addGestureRecognizer:tapRecognizer];
}

- (void)showAttacks:(id)recognizer
{
    CGPoint location = [recognizer locationInView:self.overlay];
	int xLoc, yLoc;
	xLoc = location.x = (int)floorf(location.x / (self.overlay.bounds.size.width / NUMGRIDS));
	yLoc = location.y = (int)floorf(location.y / (self.overlay.bounds.size.height / NUMGRIDS));
    [self.coordinatesLabel setText:[NSString stringWithFormat:@"Coordinates:%c%d", XLEGEND[xLoc], yLoc]];
	int result[MAXPLAYERS] = {NOATTACK, NOATTACK, NOATTACK, NOATTACK, NOATTACK};
	int turnOfAttack[MAXPLAYERS];
	BOOL hitFound = NO;
	for (int j = 0; j < self.currGame.turnNumber; j++) {
		for (int i = 1; i < [self.currGame.players count]; i++) {
			if (CGPointEqualToPoint(location, [self.currGame.players[i] moves][j])) {
				result[i] = MISS;
				turnOfAttack[i] = j;
				if (!hitFound) {
					for (Ship *aShip in [self.currGame.players[LOCALPLAYER] fleet]) {
						if ([aShip isHit:location]) {
							result[i] = HIT;
							break;
						}
					}
				}
			}
		}
		if (!hitFound && (result[1]==HIT || result[2]==HIT || result[3]==HIT || result[4]==HIT))
			hitFound = YES;
	}
	for (int i = 1; i < [self.currGame.players count]; i++) {
		result[i] != NOATTACK ?
		[(UILabel *)[self viewWithTag:i] setText:[NSString stringWithFormat:@"%@ %@ on turn: %d", [self.currGame.players[i] name], [self resultString:result[i]], turnOfAttack[i]]] :
		[(UILabel *)[self viewWithTag:i] setText:@""];
	}
}  //TODO - Verify fix - that multiple hits on the same turn, all register.

-(UIView *)viewWithTag:(int)tag {
//Returns the UIView with the matching tag
	__block UIView *viewWanted = nil;
	[self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if ([obj tag] == tag) {
			viewWanted = obj;
			*stop = YES;
		}
	}];
	return viewWanted;
}

-(NSString *)resultString:(int)result
{
	return result == MISS ? @"Missed" : @"Hit";
}

- (IBAction)backButtonPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
