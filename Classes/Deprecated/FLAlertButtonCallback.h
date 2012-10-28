//
//	FLAlertButtonCallback.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/19/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCallbackObject.h"

@interface FLAlertButtonCallback : NSObject {
@private;
	NSString* _buttonTitle;
	FLCallbackObject* _callback;
    dispatch_block_t _blockCallback;
}

@property (readwrite, retain, nonatomic) NSString* buttonTitle;
@property (readwrite, retain, nonatomic) FLCallbackObject* buttonCallback;
@property (readwrite, copy, nonatomic) dispatch_block_t blockCallback;

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle;

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle 
                                        target:(id) targetOrObjectContainer 
                                        action:(SEL) action;

+ (FLAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle 
                                 blockCallback:(dispatch_block_t) blockCallback;

+ (FLAlertButtonCallback*) cancelButtonCallback;

- (void) releaseCallbacks;

@end