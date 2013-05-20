//
//	GtAlertView.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/24/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAlertView.h"


@implementation GtAlertView

@synthesize clickedButtonIndex = m_clickedButton;
@synthesize userInfo = m_userInfo;

- (id)initWithTitle:(NSString *)title 
			message:(NSString *)message	 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	if((self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]))
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
			while ((obj = va_arg(valist, id)))
			{ 
				[self addButtonWithTitle:obj];
			}
			va_end(valist);
		}
		
		
	}
	
	return self;
}

- (id)initWithTitle:(NSString *)title 
			message:(NSString *)message	 
			cancelButtonCallback:(GtAlertButtonCallback *)cancelButtonCallback 
			otherButtonCallbacks:(GtAlertButtonCallback *)otherButtonCallbacks, ...;

{
	if((self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]))
	{
		m_items = [[NSMutableArray alloc] init];
	
		if(cancelButtonCallback)
		{
			[self addButtonWithTitle:cancelButtonCallback.buttonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
			[m_items addObject:cancelButtonCallback];
		
		}
		
		if(otherButtonCallbacks)
		{
			[self addButtonWithTitle:otherButtonCallbacks.buttonTitle];
			[m_items addObject:otherButtonCallbacks];
		
			va_list valist;
			va_start(valist, otherButtonCallbacks);	  
			GtAlertButtonCallback* cb = nil;
			while ((cb = va_arg(valist, GtAlertButtonCallback*)))
			{ 
				[self addButtonWithTitle:cb.buttonTitle];
				[m_items addObject:cb];
			}
			va_end(valist);
		}
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_userInfo);
	GtRelease(m_items);
	GtRelease(m_clickedCallback);
	GtSuperDealloc();
}

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action
{
	GtReleaseWithNil(m_clickedCallback);
	m_clickedCallback = [[GtCallbackObject alloc] initWithTarget:targetOrObjectContainer action:action];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	m_clickedButton = buttonIndex;

	if(m_clickedCallback)
	{
		[m_clickedCallback invoke:self];
	}
	
	if(m_items)
	{
		NSString* buttonTitle = [self buttonTitleAtIndex:buttonIndex];
		for(GtAlertButtonCallback* item in m_items)
		{
			if([buttonTitle isEqualToString:item.buttonTitle])
			{
                if(item.blockCallback)
                {
                    item.blockCallback();
                }
				else if(item.buttonCallback)
				{
					[item.buttonCallback invoke:self];
				}
			}
            
            [item releaseCallbacks];
		}
	}
}

- (BOOL) wasCancelled
{
	return m_clickedButton == self.cancelButtonIndex;
}

@end
