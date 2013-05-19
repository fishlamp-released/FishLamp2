//
//	FLDebugLog.m
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDebug.h"

#if DEBUG
BOOL FLIsRunningInSimulator() {
	return [[UIDevice currentDevice].model rangeOfString:@"Simulator"].length > 0;
}

void _FLLogViewHierarchy(UIView* view, int count) {
    NSMutableString* spaces = [NSMutableString string];
    for(int i = 0; i < count; i++) [spaces appendString:@" "];

    FLLog(@"%@%@", spaces, [view description]);
    for(UIView* subview in view.subviews) {
        _FLLogViewHierarchy(subview, count + 1);
    }
}

void FLLogViewHierarchy(UIView* view) {
    _FLLogViewHierarchy(view, 0);
}

void FLLogAllWindows() {
	NSArray* windows = [UIApplication sharedApplication].windows;
	
	FLLog(@"Logging %d windows", windows.count);
	
	for(UIWindow* window in windows) {
		FLLogViewHierarchy(window);
	}
}

#endif