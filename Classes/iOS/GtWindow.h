//
//  GtWindow.h
//  myZenfolio
//
//  Created by Mike Fullerton on 5/21/13.
//	Created by Mike Fullerton on 4/12/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#define GtDeviceWasShakenNotification @"SHAKEN"


@protocol GtEventInterceptor <NSObject>
- (BOOL) didInterceptEvent:(UIEvent*) event;
@end

@interface GtWindow : UIWindow {
@private
	NSMutableArray* m_eventInterceptors;
}

- (void) addEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 
- (void) removeEventInterceptor:(id<GtEventInterceptor>) eventReceiver;
- (BOOL) hasEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 
@end

@interface UIWindow (GtEventInterceptor)
- (void) addEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 
- (void) removeEventInterceptor:(id<GtEventInterceptor>) eventReceiver;
- (BOOL) hasEventInterceptor:(id<GtEventInterceptor>) eventReceiver; 
@end