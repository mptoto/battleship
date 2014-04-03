//
//  AttacksByOpponentsView.m
//  battleship
//
//  Created by Michael M. Mayer on 3/24/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import "AttacksByOpponentsView.h"
#import "BBdefs.h"
#import "Player.h"

@implementation AttacksByOpponentsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.results = NULL;
		self.splash = [UIImage imageNamed:@"splash"];
		self.explosion = [UIImage imageNamed:@"explosion"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef cref = UIGraphicsGetCurrentContext();
	CGSize gridSize = CGSizeMake(self.bounds.size.width / NUMGRIDS, self.bounds.size.height / NUMGRIDS);
	CGRect imageRect = CGRectMake(0, 0, gridSize.width, gridSize.height);
	CGContextSaveGState(cref);
	for(int i = 0; i < NUMGRIDS; i++) {
		for (int j = 0; j < NUMGRIDS; j++) {
			int index = i*NUMGRIDS+j;
			if (_results[index] != NOATTACK) {
				imageRect.origin.x = j*gridSize.width;
				imageRect.origin.y = i*gridSize.height;
				if (_results[index] == MISS)
						[self.splash drawInRect:imageRect];
					else
						[self.explosion drawInRect:imageRect];
			}
		}
	}
	CGContextRestoreGState(cref);
}

-(void)dealloc
{
	NSLog(@"Dealloc: Getting rid of an AttacksByOpponentsView");
	if (_results) {
		free(_results);
	}
}


@end
