//
//  ViewController.m
//  battleship
//
//  Created by Matthew Toto on 11/24/13.
//  Copyright (c) 2013 Matthew Toto. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayerViewController *destVC = [segue destinationViewController];
	destVC.currGame = self.currGame;
    [destVC setTitle:@"Against todd"];
}

- (void)viewDidLoad
{
    //This title will use a placeholder to import the opponentsName field.
    [self setTitle:@"Opponents Board"];
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showGestureForTapRecognizer:)];
     [self.boardImage addGestureRecognizer:tapRecognizer];

}

//Action taken on the Gesture
-(IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.boardImage];
    //Michael's code to find the touch point and translate into 10x10 grid
	location.x =(int)floorf(location.x / (self.boardImage.bounds.size.width / 10));
	location.y=(int)floorf(location.y / (self.boardImage.bounds.size.height / 10));
    //Convert gridIndex Int into a string
    NSString *gridIndexString = [NSString stringWithFormat:@"%.0lf, %.0lf", location.x, location.y];
    //Show tapped coordinates
    self.CoordinatesSelectedField.text = gridIndexString;
	
	CGFloat modX = (int)location.x * (int)(self.boardImage.bounds.size.width / 10) + (int)(self.boardImage.bounds.size.width / 20);
	CGFloat modY = (int)location.y * (int)(self.boardImage.bounds.size.height / 10) + (int)(self.boardImage.bounds.size.height / 20);
	
    //Draw the peg
    [self drawImageForGestureRecognizer:recognizer atPoint:CGPointMake(modX, modY)];
	//    [UIView animateWithDuration:1.0 animations:^{
	//        self.pegView.alpha = 0.0;
	//  }];
}

//Insert pin picture on board where it's touched.  This will be changed to an if statement to determine color of pin.
-(void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint)centerPoint {
    CGPoint convertedPoint = [[self view] convertPoint:centerPoint fromView:self.boardImage];
    self.pegView.image = [UIImage imageNamed:@"circle_white_15x15.png"];
    self.pegView.center = convertedPoint;
    self.pegView.alpha = 1.0;
}

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
