//
//	GtApplication.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/12/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtDeviceWasShakenNotification @"SHAKEN"

@protocol GtEventInterceptor <NSObject>
- (BOOL) didInterceptEvent:(UIEvent*) event;
@end

@interface GtApplication : UIApplication {
@private
	NSMutableArray* m_eventInterceptors;
}

- (void) addEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 
- (void) removeEventInterceptor:(id<GtEventInterceptor>) eventReceiver;
- (BOOL) hasEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 

+ (GtApplication*) sharedApplication;

@end
