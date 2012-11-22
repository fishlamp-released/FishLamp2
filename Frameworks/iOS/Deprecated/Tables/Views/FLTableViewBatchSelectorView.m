//
//  FLTableViewBatchSelectorView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewBatchSelectorView.h"

@implementation FLTableViewBatchSelectorView

@synthesize tableView = _tableView;

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.backgroundColor = [UIColor clearColor];
		self.multipleTouchEnabled = YES;
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = NO;
	}
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_tableView touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_tableView touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_tableView touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_tableView touchesCancelled:touches withEvent:event];
}

@end
