//
//  GamesListViewController.h
//  battleship
//
//  Created by Matthew Toto on 11/27/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GameStates.h"


@interface GamesListViewController : UITableViewController
{
   // NSMutableArray *dataArray;
}

@property (strong, nonatomic) AppDelegate *theApp;

- (IBAction)newGame:(id)sender;

@end
