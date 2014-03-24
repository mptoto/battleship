//
//  battleshipTests.m
//  battleshipTests
//
//  Created by Michael M. Mayer on 11/24/13.
//  Copyright (c) 2013 Michael M. Mayer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BBdefs.h"
#import "Opponent.h"
#import "Ships.h"

@interface battleshipTests : XCTestCase
@property NSArray *fleet;
@end

@implementation battleshipTests

- (void)setUp
{
    [super setUp];
	self.fleet = @[[[Ships alloc] init:2], [[Ships alloc] init:3], [[Ships alloc] init:3], [[Ships alloc] init:4], [[Ships alloc] init:5]];
	Ships * ship = self.fleet[0];
	ship.start = CGPointMake(4,5);
	ship.isVertical = NO;
	ship.isPlaced = NO;

	ship = self.fleet[1];
	ship.start = CGPointMake(9,9);
	ship.isVertical = YES;
	ship.isPlaced = YES;

	ship = self.fleet[2];
	ship.start = CGPointMake(2,0);
	ship.isVertical = NO;
	ship.isPlaced = YES;

	ship = self.fleet[3];
	ship.start = CGPointMake(5,8);
	ship.isVertical = NO;
	ship.isPlaced = NO;

	ship = self.fleet[4];
	ship.start = CGPointMake(1,5);
	ship.isVertical = YES;
	ship.isPlaced = YES;

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCanShipBePlaced
{
	//extending out of bounds test cases
	Ships *ship = [[Ships alloc] init:2];
	ship.start = CGPointMake(9,0);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Out of Bounds - up - upper right", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(9,0);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Out of Bounds - right - upper right", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(3,1);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Out of Bounds - up - upper left", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(8,6);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Out of Bounds - right - lower right", __PRETTY_FUNCTION__);

	//starting out of bounds test cases
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(5,-3);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Start Out of Bounds - bad low-y", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(-2,5);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Start Out of Bounds - bad low x", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(10,5);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Start Out of Bounds - bad hi x", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(5,11);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Start Out of Bounds - bad hi y", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(10,-1);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Start Out of Bounds - both bad", __PRETTY_FUNCTION__);
	
	//crossing over not placed ships (ok)
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(4,5);
	ship.isVertical = YES;
	XCTAssertTrue([ship canShipBePlaced:self.fleet], @"%s: Overlapping a not placed ship - same start", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(5,6);
	ship.isVertical = YES;
	XCTAssertTrue([ship canShipBePlaced:self.fleet], @"%s: Overlapping a not placed ship - crossing", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:2];
	ship.start = CGPointMake(4,5);
	ship.isVertical = NO;
	XCTAssertTrue([ship canShipBePlaced:self.fleet], @"%s: Overlapping a not placed ship - same", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(3,5);
	ship.isVertical = NO;
	XCTAssertTrue([ship canShipBePlaced:self.fleet], @"%s: Overlapping a not placed ship - longer", __PRETTY_FUNCTION__);
		
	//crossing over placed ships (not ok)
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,5);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - same start crossing", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,5);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - same start on top - shorter", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:5];
	ship.start = CGPointMake(1,0);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - same start on top - longer", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(0,3);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - crossing", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(1,4);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - crossing", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,4);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - on - not same start", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,6);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - off1 - not same start- shorter", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(1,7);
	ship.isVertical = YES;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - off2 - not same start- shorter", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(1,0);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - off1 - not same start -longer", __PRETTY_FUNCTION__);
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,0);
	ship.isVertical = NO;
	XCTAssertFalse([ship canShipBePlaced:self.fleet], @"%s: Overlapping - off1 - not same start -same", __PRETTY_FUNCTION__);
	
	//same size - on top of placed ship (ok - erasing)
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(9,9);
	ship.isVertical = YES;
	ship.isPlaced = YES;
	XCTAssertTrue([ship canShipBePlaced:self.fleet], @"%s: laying same over placed ship", __PRETTY_FUNCTION__);

}

- (void)testShipsAreEqual
{
	//True Cases
	Ships *ship = [[Ships alloc] init:5];
	ship.start = CGPointMake(1,5);
	ship.isVertical = YES;
	ship.isPlaced = YES;
	XCTAssertTrue([ship isEqual:self.fleet[4]], "Battleships should have been equal");
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(2,0);
	ship.isVertical = NO;
	ship.isPlaced = YES;
	XCTAssertTrue([ship isEqual:self.fleet[2]], "Destroyers should have been equal");
	
	//False cases
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(5,8);
	ship.isVertical = NO;
	ship.isPlaced = NO;
	XCTAssertFalse([ship isEqual:self.fleet[3]], "Should have failed due to wrong ship length");
	
	ship = [[Ships alloc] init:4];
	ship.start = CGPointMake(5,7);
	ship.isVertical = NO;
	ship.isPlaced = YES;
	XCTAssertFalse([ship isEqual:self.fleet[3]], "Should have failed due to wrong start");
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(0,0);
	ship.isVertical = YES;
	ship.isPlaced = YES;
	XCTAssertFalse([ship isEqual:self.fleet[2]], "Should have failed due to wrong orienatation");

	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(9,9);
	ship.isVertical = YES;
	ship.isPlaced = NO;
	XCTAssertFalse([ship isEqual:self.fleet[1]], "Should have failed due to wrong isPlaced");
	
	ship = [[Ships alloc] init:3];
	ship.start = CGPointMake(1,1);
	ship.isVertical = NO;
	ship.isPlaced = NO;
	XCTAssertFalse([ship isEqual:self.fleet[4]], "Should have failed due to wrong everything");
}

@end
