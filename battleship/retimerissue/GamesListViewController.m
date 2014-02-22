//
//  GamesListViewController.m
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "GamesListViewController.h"
#import "ViewController.h"

@interface GamesListViewController () <UITableViewDataSource>

@end


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
	self.theApp = [[UIApplication sharedApplication] delegate];
	[self.theApp setMyTableView:[self tableView]];
    
    //Create an array to hold older games
    NSMutableArray *oldGames = [[NSMutableArray alloc]init];
    //Add 2 make believe games to the oldGames Array
    GameStates *oldGame1 = [[GameStates alloc]init];
    GameStates *oldGame2 = [[GameStates alloc]init];
    [oldGames addObject:oldGame1];
    [oldGames addObject:oldGame2];
//    for (id games in oldGames) {
//        NSLog(@"%@", games);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.theApp gameStates] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return @"Current Games";
    if(section == 1)
        return @"Old Games";
    else
        return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];// forIndexPath:indexPath];
	GameStates *current = [[self.theApp gameStates] objectAtIndex:indexPath.row];
    [cell.textLabel setText:[current opponentName]];
    //turn "turnNumber" into string
    
    NSString *turnNumberString = [NSString stringWithFormat:@"Turn: %i, time left %2.0d:%2.0d:%2.0d",[current turnNumber], (int)[current timeLeft]/(60*60), ((int)[current timeLeft]%(60*60))/60, ((int)[current timeLeft]%(60*60))%60];
    [cell.detailTextLabel setText:turnNumberString];
    //set picture for cell
    UIImage *boardImageThumbnail = [UIImage imageNamed:[current boardMap]];
    cell.imageView.image = boardImageThumbnail;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (IBAction)newGame:(id)sender {
	[[self.theApp gameStates] addObject:[[GameStates alloc ]init]];
	[self.tableView reloadData];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
	if(!self.theApp.clockTicker)
		self.theApp.clockTicker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.theApp selector:@selector(updateClocks:) userInfo:nil repeats:YES];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.theApp.clockTicker invalidate];
	self.theApp.clockTicker = nil;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!self.theApp.clockTicker)
		self.theApp.clockTicker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.theApp selector:@selector(updateClocks:) userInfo:nil repeats:YES];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//    UIViewController *myVC = [segue destinationViewController];

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


@end
