//
//  GtSendCrashLogs.h
//  MyZen
//
//  Created by Mike Fullerton on 12/18/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

@interface GtSendCrashLogs : NSObject {
    NSString* m_emailAddress;
}

+ (BOOL) hasCrashLogsToSend;

- (id) initWithEmailAddress:(NSString*) emailAddress;

- (void) deleteCrashLogs;

- (void) composeEmail:(UIViewController*) viewController;

@end
