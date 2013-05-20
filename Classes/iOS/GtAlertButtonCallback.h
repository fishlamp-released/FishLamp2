//
//	GtAlertButtonCallback.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/19/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCallbackObject.h"

@interface GtAlertButtonCallback : NSObject {
@private;
	NSString* m_buttonTitle;
	GtCallbackObject* m_callback;
    GtBlock m_blockCallback;
}

@property (readwrite, retain, nonatomic) NSString* buttonTitle;
@property (readwrite, retain, nonatomic) GtCallbackObject* buttonCallback;
@property (readwrite, copy, nonatomic) GtBlock blockCallback;

+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle;

+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle 
                                        target:(id) targetOrObjectContainer 
                                        action:(SEL) action;

+ (GtAlertButtonCallback*) alertButtonCallback:(NSString*) buttonTitle 
                                 blockCallback:(GtBlock) blockCallback;

+ (GtAlertButtonCallback*) cancelButtonCallback;

- (void) releaseCallbacks;

@end