//
//  GamesListViewController.m
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "GamesListViewController.h"
#import "ViewController.h"
#import "Game.h"

@implementation GamesListViewController


- (id)initWithStyle:(UITableViewStyle)style
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
			[currGame setTimeLeft:24.0 * 60.0 * 60.0 - elapsedTime];
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
	Game *current = [GameRepo sharedRepo].allGames[indexPath.section][indexPath.row];
    [cell.textLabel setText:[current opponentNames][0]];

    //turn "turnNumber" into string
    NSString *turnNumberString = [NSString stringWithFormat:@"Turn: %i, time left %2.0d:%2.0d:%2.0d",[current turnNumber], (int)[current timeLeft]/(60*60), ((int)[current timeLeft]%(60*60))/60, ((int)[current timeLeft]%(60*60))%60];
    [cell.detailTextLabel setText:turnNumberString];

    //set picture for cell
    cell.imageView.image = [UIImage imageNamed:[current boardMap]];
    
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
	ViewController *destVC = [segue destinationViewController];
	if([segue.identifier isEqualToString:@"PlaceShips"]){
		Game *newGame = [[GameRepo sharedRepo] generateNewGame];
		destVC.currGame = newGame;
	}
	else {
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		destVC.currGame = [[GameRepo sharedRepo] allGames][indexPath.section][indexPath.row];
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
