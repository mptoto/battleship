//
//  GamesListViewController.h
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GameRepo.h"


@interface GamesListViewController : UITableViewController
{
   // NSMutableArray *dataArray;
}
@property (strong, nonatomic) NSTimer *clockTicker;

- (IBAction)newGame:(id)sender;
- (void)updateClocks:(NSTimer *)myTimer;

@end
