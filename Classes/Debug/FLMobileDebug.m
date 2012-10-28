//
//	FLDebugLog.m
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLDebug.h"

#if DEBUG
BOOL FLIsRunningInSimulator() {
	return [[UIDevice currentDevice].model rangeOfString:@"Simulator"].length > 0;
}

void _FLLogViewHierarchy(UIView* view, int count) {
    NSMutableString* spaces = [NSMutableString string];
    for(int i = 0; i < count; i++) [spaces appendString:@" "];

    FLCLog(@"%@%@", spaces, [view description]);
    for(UIView* subview in view.subviews) {
        _FLLogViewHierarchy(subview, count + 1);
    }
}

void FLLogViewHierarchy(UIView* view) {
    _FLLogViewHierarchy(view, 0);
}

void FLLogAllWindows() {
	NSArray* windows = [UIApplication sharedApplication].windows;
	
	FLCLog(@"Logging %d windows", windows.count);
	
	for(UIWindow* window in windows) {
		FLLogViewHierarchy(window);
	}
}

#endif