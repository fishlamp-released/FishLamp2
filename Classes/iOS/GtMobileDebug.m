//
//	GtDebug.m
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDebug.h"

#if DEBUG
BOOL GtIsRunningInSimulator()
{
	return [[UIDevice currentDevice].model rangeOfString:@"Simulator"].length > 0;
}

void _GtLogViewHierarchy(UIView* view, int count)
{
    NSMutableString* spaces = [NSMutableString string];
    for(int i = 0; i < count; i++) [spaces appendString:@" "];

    GtLog(@"%@%@", spaces, [view description]);
    for(UIView* subview in view.subviews)
    {
        _GtLogViewHierarchy(subview, count + 1);
    }
}

void GtLogViewHierarchy(UIView* view)
{
    _GtLogViewHierarchy(view, 0);
}

void GtLogAllWindows()
{
	NSArray* windows = [UIApplication sharedApplication].windows;
	
	printf("Logging %d windows\n", windows.count);
	
	for(UIWindow* window in windows)
	{
		GtLogViewHierarchy(window);
	}
}

#endif