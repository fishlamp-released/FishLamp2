//
//  GtUtilities.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/3/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#define GtSetRandomSeed() srandom(time(NULL))
#define GtGetRandomInt(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))

@interface GtUtilities : NSObject {
}

+ (void) initializeFishLamp;

@end

// pass in Apple's macros like __IPHONE_3_0
extern BOOL IsAtLeaskSdkVersion(int minVersion);

extern int GtApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);