//
//  ViewController.m
//  battleship
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayerViewController *destVC = [segue destinationViewController];
	destVC.currGame = self.currGame;
    [destVC setTitle:@"Player's Status"];
}

- (void)viewDidLoad
{
    //This title will use a placeholder to import the opponentsName field.
    [self setTitle:@"Opponents' Status"];
}

//Action taken on the Gesture
-(IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.boardImage];

	location.x =(int)floorf(location.x / (self.boardImage.bounds.size.width / NUMGRIDS));
	location.y=(int)floorf(location.y / (self.boardImage.bounds.size.height / NUMGRIDS));
    //Convert gridIndex Int into a string
    NSString *gridIndexString = [NSString stringWithFormat:@"%.0lf, %.0lf", location.x, location.y];
    //Show tapped coordinates
    self.CoordinatesSelectedField.text = gridIndexString;
	
	CGFloat modX = (int)location.x * (int)(self.boardImage.bounds.size.width / NUMGRIDS) + (int)(self.boardImage.bounds.size.width / (NUMGRIDS * 2));
	CGFloat modY = (int)location.y * (int)(self.boardImage.bounds.size.height / NUMGRIDS) + (int)(self.boardImage.bounds.size.height / (NUMGRIDS * 2));
	
    //Draw the peg
    [self drawImageForGestureRecognizer:recognizer atPoint:CGPointMake(modX, modY)];
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
