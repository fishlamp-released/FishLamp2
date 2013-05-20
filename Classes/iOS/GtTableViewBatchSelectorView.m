//
//  GtTableViewBatchSelectorView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewBatchSelectorView.h"

@implementation GtTableViewBatchSelectorView

@synthesize tableView = m_tableView;

- (id) initWithFrame:(CGRect) frame
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
	[m_tableView touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[m_tableView touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[m_tableView touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[m_tableView touchesCancelled:touches withEvent:event];
}

@end
