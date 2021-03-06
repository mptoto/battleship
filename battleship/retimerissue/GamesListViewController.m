//
//  GamesListViewController.m
//  battleship
//
//  Created by Michael M. Mayer on 11/27/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "GamesListViewController.h"
#import "AttackViewController.h"
#import "PlaceShipsViewController.h"
#import "Game.h"
#import "BBdefs.h"

@implementation GamesListViewController


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.clockTicker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClocks:) userInfo:nil repeats:YES];
	[self.clockTicker setTolerance:1.0];

}

- (void)updateClocks:(NSTimer *)myTimer {
    NSDate *now = [[NSDate alloc] init];  //moved this outside for loop
	for (int i = 0; i < [[[GameRepo sharedRepo] allGames] count]; i++) {
		for (Game *currGame in [[GameRepo sharedRepo] allGames][i]) {
			NSTimeInterval elapsedTime = [now timeIntervalSinceDate: [currGame  turnStartTime]];
			if(elapsedTime > SECS_IN_DAY)
			{
				int elapsedTurns = (int)elapsedTime / SECS_IN_DAY;
				for (int j=0; j < elapsedTurns; j++) {
					if (currGame.isMyMove) {
						[currGame.players[LOCALPLAYER] moves][currGame.turnNumber] = CGPointMake(INVALID_COORD, INVALID_COORD);
					}
					[currGame generateTurn];
				}
				elapsedTime = (int)elapsedTime % SECS_IN_DAY;
				currGame.turnStartTime = [now dateByAddingTimeInterval:-elapsedTime];
			}
			[currGame setTimeLeft:(double)SECS_IN_DAY - elapsedTime];
		}
	}
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[GameRepo sharedRepo].allGames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GameRepo sharedRepo].allGames[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSString *headerString;
	if(section == 0)
        headerString = @"Your Turn";
    else if(section == 1)
        headerString =  @"Waiting on Opponent";
    else
        headerString =  @"Waiting for Game to Finish";
	
	return headerString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];// forIndexPath:indexPath];
	Game *currGame = [GameRepo sharedRepo].allGames[indexPath.section][indexPath.row];
    [cell.textLabel setText:[currGame.players[LOCALPLAYER] name]];

    //turn "turnNumber" into string
    NSString *turnNumberString = [NSString stringWithFormat:@"Turn: %i, time left %2.02d:%2.02d:%2.02d",[currGame turnNumber], (int)[currGame timeLeft]/(60*60), ((int)[currGame timeLeft]%(60*60))/60, ((int)[currGame timeLeft]%(60*60))%60];
    [cell.detailTextLabel setText:turnNumberString];

    //set picture for cell
    cell.imageView.image = [UIImage imageNamed:[currGame boardMap]];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[GameRepo sharedRepo] removeGameAt:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
	if(!self.clockTicker)
		self.clockTicker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClocks:) userInfo:nil repeats:YES];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.clockTicker invalidate];
	self.clockTicker = nil;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!self.clockTicker)
		self.clockTicker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClocks:) userInfo:nil repeats:YES];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	UIViewController *destVC = [segue destinationViewController];
	if([segue.identifier isEqualToString:@"PlaceShips"]){
		PlaceShipsViewController * psVC = (PlaceShipsViewController *)destVC;
		Game *newGame = [[GameRepo sharedRepo] generateNewGame];
		psVC.currGame = newGame;
	}
	else {
		AttackViewController * aVC = (AttackViewController *)destVC;
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		aVC.currGame = [[GameRepo sharedRepo] allGames][indexPath.section][indexPath.row];
	}
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
