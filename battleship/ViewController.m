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
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.overlayView action:@selector(placeShip:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.overlayView addGestureRecognizer:panRecognizer];
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
