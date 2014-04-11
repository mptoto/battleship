//
//  GamesListViewController.h
//  battleship
//
//  Created by Michael M. Mayer on 11/27/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GameRepo.h"

#define SECS_IN_DAY 86400


@interface GamesListViewController : UITableViewController <UITableViewDataSource>
@property (strong, nonatomic) NSTimer *clockTicker;

- (void)updateClocks:(NSTimer *)myTimer;

@end
