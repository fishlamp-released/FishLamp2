//
//	FLApplication.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/12/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define FLDeviceWasShakenNotification @"SHAKEN"

#import "FLApplicationEventInterceptor.h"
#import "FLApplicationDelegate.h"
#import "FLOperationContext.h"

@interface FLApplication : UIApplication {
@private
	NSMutableArray* _eventInterceptors;
    NSMutableArray* _addList;
    NSMutableArray* _removeList;
    
    NSTimeInterval _lastActivate;
    
    FLOperationContextManager* _operationContextManager;
}

+ (FLApplication*) instance;

- (void) addEventInterceptor:(id<FLApplicationEventInterceptor>) eventReceiver; 
- (void) removeEventInterceptor:(id<FLApplicationEventInterceptor>) eventReceiver;
- (BOOL) hasEventInterceptor:(id<FLApplicationEventInterceptor>) eventReceiver; 

+ (FLApplication*) sharedApplication;

@property (readonly, assign, nonatomic) NSTimeInterval lastActivateTime; // changes when session changes or user switches app into foreground

@property (readonly, strong) FLOperationContextManager* operationContextManager;

@end
