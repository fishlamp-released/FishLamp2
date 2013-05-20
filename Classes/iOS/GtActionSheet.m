//
//	GtActionSheet.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionSheet.h"
#import "GtGeometry.h"

@implementation GtActionSheet

@synthesize buttonIndex = m_clickedButton;

- (id)initWithTitle:(NSString *)title 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 destructiveButtonTitle:(NSString *)destructiveButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	if((self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
	{
		self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

		if(destructiveButtonTitle)
		{
			[self addButtonWithTitle:destructiveButtonTitle];
			self.destructiveButtonIndex = self.numberOfButtons - 1;
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
		
		if(cancelButtonTitle)
		{
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
		}
	}
	
	return self;
}

- (id)initWithTitle:(NSString *)title 
 cancelButtonCallback:(GtAlertButtonCallback *)cancelButtonCallback
 destructiveButtonCallback:(GtAlertButtonCallback *)destructiveButtonCallback
 otherButtonCallbacks:(GtAlertButtonCallback *)otherButtonCallbacks, ...
{
	if((self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
	{
		self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	
		m_items = [[NSMutableArray alloc] init];
	
		if(destructiveButtonCallback)
		{
			[self addButtonWithTitle:destructiveButtonCallback.buttonTitle];
			self.destructiveButtonIndex = self.numberOfButtons - 1;
			[m_items addObject:destructiveButtonCallback];
		}
		
		if(otherButtonCallbacks)
		{
			[self addButtonWithTitle:otherButtonCallbacks.buttonTitle];
			[m_items addObject:otherButtonCallbacks];
		
			va_list valist;
			va_start(valist, otherButtonCallbacks);	  
			id obj = nil;
			while ((obj = va_arg(valist, id)))
			{ 
				[self addButtonWithTitle:[obj buttonTitle]];
				[m_items addObject:obj];
			}
			va_end(valist);
		}
		
		if(cancelButtonCallback)
		{
			[self addButtonWithTitle:cancelButtonCallback.buttonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
			[m_items addObject:cancelButtonCallback];
		}
	}
	
	return self;

}


- (void) dealloc
{
	GtReleaseWithNil(m_items);
	GtReleaseWithNil(m_clickedCallback);
	GtSuperDealloc();
}

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action
{
	GtReleaseWithNil(m_clickedCallback);
	m_clickedCallback = [[GtCallbackObject alloc] initWithTarget:targetOrObjectContainer action:action];
}

- (BOOL) wasCancelled
{
	return m_clickedButton == self.cancelButtonIndex;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	m_clickedButton = buttonIndex;

	if(m_clickedCallback)
	{	
		[m_clickedCallback invoke:self];
	}
	
	if(m_items && buttonIndex >= 0 && buttonIndex < (NSInteger) m_items.count)
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

@end

