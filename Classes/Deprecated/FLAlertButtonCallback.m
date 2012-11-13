//
//	FLAlertButtonCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/19/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLAlertButtonCallback.h"

@implementation FLAlertButtonCallback

@synthesize buttonCallback = _callback;
@synthesize buttonTitle = _buttonTitle;
@synthesize blockCallback = _blockCallback;

- (id) initWithTitle:(NSString*) buttonTitle target:(id) target action:(SEL) action
{	
	if((self = [super init]))
	{
		self.buttonTitle = buttonTitle;
		if(target)
		{
			self.buttonCallback = [FLCallbackObject callback:target action:action];
		}
	}

	return self;
}


- (id) initWithTitle:(NSString*) buttonTitle blockCallback:(dispatch_block_t) blockCallback
{	
	if((self = [super init]))
	{
		self.buttonTitle = buttonTitle;
		self.blockCallback = blockCallback;
	}

	return self;
}


+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle blockCallback:(dispatch_block_t) blockCallback
{
	return autorelease_([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle blockCallback:blockCallback]);
}

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle target:(id) target action:(SEL) action
{
	return autorelease_([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle target:target action:action]);
}

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle
{
	return autorelease_([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle target:nil action:nil]);
}

- (void) releaseCallbacks
{
    FLReleaseBlockWithNil_(_blockCallback);
    FLReleaseWithNil_(_callback);
}

- (void) dealloc
{
    release_(_blockCallback);
	release_(_buttonTitle);
	release_(_callback);
	super_dealloc_();
}

+ (FLAlertButtonCallback*) cancelButtonCallback
{
    FLReturnStaticObjectFromBlock( ^{ 
        return autorelease_([[FLAlertButtonCallback alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) target:nil action:nil]); });

}

@end