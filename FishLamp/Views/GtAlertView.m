//
//  GtAlertView.m
//  MyZen
//
//  Created by Mike Fullerton on 12/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtAlertView.h"


@implementation GtAlertView

@synthesize clickedButtonIndex = m_clickedButton;

- (id)initWithTitle:(NSString *)title 
		    message:(NSString *)message  
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	if(self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil])
	{
		if(cancelButtonTitle)
		{
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
		}
		
		if(otherButtonTitles)
		{
			[self addButtonWithTitle:otherButtonTitles];
		
			va_list valist;
			va_start(valist, otherButtonTitles);   
			id obj = nil;
			while (obj = va_arg(valist, id))
			{ 
				[self addButtonWithTitle:obj];
			}
			va_end(valist);
		}
		
		
	}
	
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_clickedCallback);
    [super dealloc];
}

- (void) setButtonClickedCallback:(id) target action:(SEL) action
{
	GtReleaseWithNil(m_clickedCallback);
	m_clickedCallback = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:action];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	m_clickedButton = buttonIndex;

	if(m_clickedCallback)
	{
		[m_clickedCallback invoke:self];
	}
}

- (BOOL) wasCancelled
{
	return m_clickedButton == self.cancelButtonIndex;
}

@end
