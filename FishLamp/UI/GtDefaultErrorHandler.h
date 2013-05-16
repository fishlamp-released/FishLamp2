//
//  GtDefaultErrorHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/17/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtActionManager.h"
#import "GtObjectDatabase.h"
#import "GtWeakReference.h"
#import "GtCoreDefaultErrorHandler.h"
#import "GtReachability.h"

@interface GtDefaultErrorHandler : GtCoreDefaultErrorHandler {
	GtWeakReference* m_notificationView;
    GtReachability* m_reachability;
}

// NOTE, to set your own, subclass this and then call [GtDefaultErrorHandler setInstance:refToYourErrorHandler
GtSingletonProperty(GtDefaultErrorHandler);

@property (readwrite, assign, nonatomic) GtReachability* reachability;

- (NSArray*) getAllCrashLogPaths;
- (void) deleteAllCrashLogs;
- (BOOL) hasCrashLogs;
- (BOOL) isCrashLog:(NSString*) path;

@end

extern void GtDefaultUncaughtExceptionHandler(NSException* exception);
