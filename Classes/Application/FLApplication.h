//
//	FLApplication.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/12/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLDeviceWasShakenNotification @"SHAKEN"

@protocol FLEventInterceptor <NSObject>
- (BOOL) didInterceptEvent:(UIEvent*) event;
@end

@interface FLApplication : UIApplication {
@private
	NSMutableArray* _eventInterceptors;
    NSMutableArray* _addList;
    NSMutableArray* _removeList;
}

- (void) addEventInterceptor:(id<FLEventInterceptor>) eventReceiver; 
- (void) removeEventInterceptor:(id<FLEventInterceptor>) eventReceiver;
- (BOOL) hasEventInterceptor:(id<FLEventInterceptor>) eventReceiver; 

- (void) didInitializeApp;

+ (FLApplication*) sharedApplication;

@end
