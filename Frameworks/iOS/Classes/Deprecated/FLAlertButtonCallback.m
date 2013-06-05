//
//	FLAlertButtonCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/19/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	return FLAutorelease([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle blockCallback:blockCallback]);
}

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle target:(id) target action:(SEL) action
{
	return FLAutorelease([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle target:target action:action]);
}

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle
{
	return FLAutorelease([[FLAlertButtonCallback alloc] initWithTitle:buttonTitle target:nil action:nil]);
}

- (void) releaseCallbacks
{
    FLReleaseBlockWithNil(_blockCallback);
    FLReleaseWithNil(_callback);
}

- (void) dealloc
{
    FLRelease(_blockCallback);
	FLRelease(_buttonTitle);
	FLRelease(_callback);
	FLSuperDealloc();
}

+ (FLAlertButtonCallback*) cancelButtonCallback
{
    FLReturnStaticObjectFromBlock( ^{ 
        return FLAutorelease([[FLAlertButtonCallback alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) target:nil action:nil]); });

}

@end