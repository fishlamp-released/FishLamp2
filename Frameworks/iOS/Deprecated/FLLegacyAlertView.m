//
//	FLLegacyAlertView.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLegacyAlertView.h"

@implementation FLLegacyAlertView

@synthesize clickedButtonIndex = _clickedButton;
@synthesize userInfo = _userInfo;

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
			cancelButtonCallback:(FLAlertButtonCallback *)cancelButtonCallback 
			otherButtonCallbacks:(FLAlertButtonCallback *)otherButtonCallbacks, ... {
	if((self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]))
	{
		_items = [[NSMutableArray alloc] init];
	
		if(cancelButtonCallback)
		{
			[self addButtonWithTitle:cancelButtonCallback.buttonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
			[_items addObject:cancelButtonCallback];
		
		}
		
		if(otherButtonCallbacks)
		{
			[self addButtonWithTitle:otherButtonCallbacks.buttonTitle];
			[_items addObject:otherButtonCallbacks];
		
			va_list valist;
			va_start(valist, otherButtonCallbacks);	  
			FLAlertButtonCallback* cb = nil;
			while ((cb = va_arg(valist, FLAlertButtonCallback*)))
			{ 
				[self addButtonWithTitle:cb.buttonTitle];
				[_items addObject:cb];
			}
			va_end(valist);
		}
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_userInfo);
	FLRelease(_items);
	FLRelease(_clickedCallback);
	super_dealloc_();
}

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action
{
	FLReleaseWithNil_(_clickedCallback);
	_clickedCallback = [[FLCallbackObject alloc] initWithTarget:targetOrObjectContainer action:action];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	_clickedButton = buttonIndex;

	if(_clickedCallback)
	{
		[_clickedCallback invoke:self];
	}
	
	if(_items)
	{
		NSString* buttonTitle = [self buttonTitleAtIndex:buttonIndex];
		for(FLAlertButtonCallback* item in _items)
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
	return _clickedButton == self.cancelButtonIndex;
}

@end
