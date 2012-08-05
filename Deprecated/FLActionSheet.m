//
//	FLActionSheet.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLActionSheet.h"
#import "FLGeometry.h"

@implementation FLActionSheet

@synthesize buttonIndex = _clickedButton;

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
 cancelButtonCallback:(FLAlertButtonCallback *)cancelButtonCallback
 destructiveButtonCallback:(FLAlertButtonCallback *)destructiveButtonCallback
 otherButtonCallbacks:(FLAlertButtonCallback *)otherButtonCallbacks, ...
{
	if((self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
	{
		self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	
		_items = [[NSMutableArray alloc] init];
	
		if(destructiveButtonCallback)
		{
			[self addButtonWithTitle:destructiveButtonCallback.buttonTitle];
			self.destructiveButtonIndex = self.numberOfButtons - 1;
			[_items addObject:destructiveButtonCallback];
		}
		
		if(otherButtonCallbacks)
		{
			[self addButtonWithTitle:otherButtonCallbacks.buttonTitle];
			[_items addObject:otherButtonCallbacks];
		
			va_list valist;
			va_start(valist, otherButtonCallbacks);	  
			id obj = nil;
			while ((obj = va_arg(valist, id)))
			{ 
				[self addButtonWithTitle:[obj buttonTitle]];
				[_items addObject:obj];
			}
			va_end(valist);
		}
		
		if(cancelButtonCallback)
		{
			[self addButtonWithTitle:cancelButtonCallback.buttonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
			[_items addObject:cancelButtonCallback];
		}
	}
	
	return self;

}


- (void) dealloc
{
	FLReleaseWithNil(_items);
	FLReleaseWithNil(_clickedCallback);
	FLSuperDealloc();
}

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action
{
	FLReleaseWithNil(_clickedCallback);
	_clickedCallback = [[FLCallbackObject alloc] initWithTarget:targetOrObjectContainer action:action];
}

- (BOOL) wasCancelled
{
	return _clickedButton == self.cancelButtonIndex;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	_clickedButton = buttonIndex;

	if(_clickedCallback)
	{	
		[_clickedCallback invoke:self];
	}
	
	if(_items && buttonIndex >= 0 && buttonIndex < (NSInteger) _items.count)
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

@end

