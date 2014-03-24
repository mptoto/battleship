//
//  ViewController.m
//  battleship
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "PlaceShipsViewController.h"


@implementation PlaceShipsViewController

- (void)viewDidLoad
{
    
    [self setTitle:@"Place Ships"];
	[self.startGameButton setHidden:YES];
    
    //Create and initilaize a tap gesture
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(placeShip:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.overlayView addGestureRecognizer:panRecognizer];
	[self.overlayView setTheShips:self.currGame.myFleet];
	[self.paletteView setTheShips:self.currGame.myFleet];
}

//Place or remove ship on the Gesture
-(void) placeShip:(UIPanGestureRecognizer *)recognizer {
	CGFloat gridWidth = self.overlayView.bounds.size.width / NUMGRIDS;
	CGFloat gridHeight = self.overlayView.bounds.size.height / NUMGRIDS;
    CGPoint location = [recognizer locationInView:self.overlayView];

	if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        self.start = CGPointMake(floorf(location.x / gridWidth), floorf(location.y /gridHeight));
		NSLog(@"%.2lf, %.2lf : %.2lf, %.2lf", location.x, location.y, self.start.x, self.start.y);
    }
	else if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
		self.currLoc = CGPointMake(floorf(location.x / gridWidth), floorf(location.y /gridHeight));
	}
	else if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
		self.currLoc = CGPointMake(floorf(location.x / gridWidth), floorf(location.y /gridHeight));
		NSLog(@"%.2lf, %.2lf : %.2lf, %.2lf", location.x, location.y, self.currLoc.x, self.currLoc.y);

		//if gesture was a straight line and length was valid for a ship
		if ((self.start.x == self.currLoc.x && fabs(self.start.y - self.currLoc.y) >= 1 && abs(self.start.y - self.currLoc.y) < 5)  ||
			(self.start.y == self.currLoc.y && fabs(self.start.x - self.currLoc.x) >= 1 && abs(self.start.x - self.currLoc.x) < 5))
		{
			BOOL isPanVertical = self.start.x == self.currLoc.x;
			int length = isPanVertical ? fabs(self.start.y - self.currLoc.y) + 1 : fabs(self.start.x - self.currLoc.x) + 1;

			CGPoint normalizedStartPoint;
			normalizedStartPoint.x = self.start.x < self.currLoc.x ? self.start.x : self.currLoc.x;
			normalizedStartPoint.y = self.start.y < self.currLoc.y ? self.currLoc.y : self.start.y;

			NSArray *theShips = self.currGame.myFleet;
			Ships *possShip = [[Ships alloc]init:length];
			possShip.isVertical = isPanVertical;
			possShip.start = normalizedStartPoint;
			possShip.isPlaced = YES;
			if ([possShip canShipBePlaced:theShips]) {
				
				for (Ships *aShip in theShips) {
					if (aShip.isPlaced && aShip.start.x == normalizedStartPoint.x && aShip.start.y == normalizedStartPoint.y && (aShip.isVertical == isPanVertical) && length == aShip.length) {
						aShip.isPlaced = NO;
						NSLog(@"Ship of length:%d should be removed", length);
						break;
					}
					else if(aShip.length == length && !aShip.isPlaced) {
						aShip.isPlaced = YES;
						aShip.isVertical = isPanVertical;
						aShip.start = normalizedStartPoint;
						break;
					}
				}
				BOOL notAllPlaced = NO;
				for (Ships *aShip in theShips) {
					if (!aShip.isPlaced) {
						notAllPlaced = YES;
						break;
					}
				}
				[self.startGameButton setHidden:notAllPlaced];
				
				[self.overlayView setNeedsDisplay];
				[self.paletteView setNeedsDisplay];
			}
		}
	}
}

-(IBAction)startGame:(id)sender
{
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancelGame:(id)sender
{
	[[[GameRepo sharedRepo] allGames][0] removeObject:self.currGame];
	[[self.presentingViewController.childViewControllers[0] tableView] reloadData];
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
