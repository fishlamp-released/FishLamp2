//
//  FLAsyncGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAsyncGridViewCell.h"

@implementation FLAsyncGridViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    switch(self.visibleView)
    {
        case FLGridViewCellVisibleViewFirst:
            [self.view setFrameOptimizedForLocation:FLRectCenterRectInRect(self.frame, [self.view frame])];
        break;
        
        case FLGridViewCellVisibleViewSecond:
            [self.view setFrameOptimizedForLocation:self.frame];
        break;
        
        case FLGridViewCellVisibleViewThird:
        break;
    }
}

- (UIView*) createViewForVisibleView:(FLGridViewCellVisibleView) visibleView
{
    switch(visibleView)
    {
        case FLGridViewCellVisibleViewFirst:
            return FLReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
        break;
        
        case FLGridViewCellVisibleViewSecond:
        break;

        case FLGridViewCellVisibleViewThird:
        break;
    }
    
    return nil;
}

//- (void) cellWillChangeVisibleViewAnimated:(BOOL) animated
//                                data:(id) dataOrNil
//                  completionCallback:(FLEventCallback) completionCallback;
//{
//    switch(self.visibleView)
//    {
//        case FLGridViewCellVisibleViewFirst:
//        {
//            UIActivityIndicatorView* progress = (UIActivityIndicatorView*) self.view;
//            progress.frame = FLRectCenterRectInRect(self.frame, progress.frame);
//            progress.hidden = NO;
//            [progress startAnimating];
//            completionCallback();
//        }
//        break;
//        
//        case FLGridViewCellVisibleViewSecond:
//        case FLGridViewCellVisibleViewThird:
//            completionCallback();
//        break;
//    }
//    
//        
//}

@end
