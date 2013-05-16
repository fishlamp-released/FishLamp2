//
//  GtDebug.m
//  FishLampiPhone
//
//  Created by Mike Fullerton on 10/14/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDebug.h"

#if DEBUG
BOOL GtIsRunningInSimulator()
{
	return [[UIDevice currentDevice].model rangeOfString:@"Simulator"].length > 0;
}

void RecursivelyLogSubViews(UIView* view, NSString* parent)
{
    NSString* typeString = [NSString stringWithFormat:@"%@/%@", parent, NSStringFromClass([view class])];
    printf(" %s\n", [typeString cStringUsingEncoding:NSASCIIStringEncoding]); 
    
    NSArray* subviews = view.subviews;
    for(UIView* subview in subviews)
    {
        RecursivelyLogSubViews(subview, typeString);
    }
}

void GtLogViewHierarchy(UIView* view)
{
    printf("Logging views for %s:\n", [NSStringFromClass([view class])  cStringUsingEncoding:NSASCIIStringEncoding]);
    printf(" Superview: %s\n", [NSStringFromClass([view.superview class])  cStringUsingEncoding:NSASCIIStringEncoding]);
    
    RecursivelyLogSubViews(view, @"");
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