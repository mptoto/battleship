//
//  ViewController.m
//  battleship
//
//  Created by Matthew Toto on 11/24/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize tapImageName;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayerViewController *ivc = [segue destinationViewController];
    [ivc setTitle:@"against todd"];
}

- (void)viewDidLoad
{
    
    //This title will use a placeholder to import the opponentsName field.
    [self setTitle:@"Opponents Board"];
    
    
    //Create and initilaize a tap gesture
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(placeShip:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.overlayView addGestureRecognizer:panRecognizer];
}

//Place or remove ship on the Gesture
-(void) placeShip:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.overlayView];
	if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        self.start = CGPointMake(floorf(location.x / GRIDSIZE), floorf(location.y /GRIDSIZE));
    }
	else if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
		self.currLoc = CGPointMake(floorf(location.x / GRIDSIZE), floorf(location.y /GRIDSIZE));
	}
	else if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
		self.currLoc = CGPointMake(floorf(location.x / GRIDSIZE), floorf(location.y /GRIDSIZE));
		if ((self.start.x == self.currLoc.x && fabs(self.start.y - self.currLoc.y) >= 1 && abs(self.start.y - self.currLoc.y) < 5)  ||
			(self.start.y == self.currLoc.y && fabs(self.start.x - self.currLoc.x) >= 1 && abs(self.start.x - self.currLoc.x) < 5))
		{
			BOOL isPanVertical = self.start.x == self.currLoc.x;
			int length = self.start.x == self.currLoc.x ? fabs(self.start.y - self.currLoc.y) + 1 : fabs(self.start.x - self.currLoc.x) + 1;
			CGPoint normalizedStartPoint;
			normalizedStartPoint.x = self.start.x < self.currLoc.x ? self.start.x : self.currLoc.x;
			normalizedStartPoint.y = self.start.y < self.currLoc.y ? self.currLoc.y : self.start.y;
			
#warning @"Must complete sending indexPath to destVC";
			NSArray *theShips = [[GameRepo sharedRepo] allGames];
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
			[self.overlayView setNeedsDisplay];
			[self.paletteView setNeedsDisplay];
		}
	}
}


//Insert pin picture on board where it's touched.  This will be changed to an if statement to determine color of pin.
//-(void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint)centerPoint {
//    CGPoint convertedPoint = [[self view] convertPoint:centerPoint fromView:self.boardImage];
//    self.pegView.image = [UIImage imageNamed:@"circle_white_15x15.png"];
//    self.pegView.center = convertedPoint;
//    self.pegView.alpha = 1.0;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firePressed:(id)sender {
    self.CoordinatesSelectedField.text = nil;
    
//    Ships *shipping = [[Ships alloc]init];
//    [shipping newSetup];
    
    UIAlertView *fireAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"You have fired!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [fireAlert show];
}



@end
