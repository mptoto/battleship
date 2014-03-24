//
//  AttacksByOpponentsView.m
//  battleship
//
//  Created by Michael M. Mayer on 3/24/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import "AttacksByOpponentsView.h"
#import "BBdefs.h"

@implementation AttacksByOpponentsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void) awakeFromNib
//{
//	[self setAlpha:0.5];
//}

- (void)drawRect:(CGRect)rect
{
	UIImage *splat = [UIImage imageNamed:@"splash"];
	UIImage *explosion = [UIImage imageNamed:@"explosion"];
	CGContextRef cref = UIGraphicsGetCurrentContext();
	CGSize gridSize = CGSizeMake(self.bounds.size.width / NUMGRIDS, self.bounds.size.height / NUMGRIDS);
	CGRect imageRect = CGRectMake(0, 0, gridSize.width, gridSize.height);
	CGContextSaveGState(cref);

	for(int i = 0; i < NUMGRIDS; i++) {
		for (int j = 0; j < NUMGRIDS; j++) {
			imageRect.origin.x = j*gridSize.width;
			imageRect.origin.y = i*gridSize.height;
			if (arc4random_uniform(2)) {
				if (arc4random_uniform(2))
					[splat drawInRect:imageRect];
				else
					[explosion drawInRect:imageRect];
			}
		}
	}
	CGContextRestoreGState(cref);

}


@end
