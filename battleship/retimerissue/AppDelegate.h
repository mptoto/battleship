//
//  AppDelegate.h
//  battleship
//
//  Created by Matthew Toto on 11/24/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameStates.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *gameStates;
@property (strong, nonatomic) NSTimer *clockTicker;
@property (strong, nonatomic) UITableView *myTableView;

- (void)updateClocks:(NSTimer *)myTimer;


@end
