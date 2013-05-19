//
//  FLAsyncGridCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncGridCell.h"

@implementation FLAsyncGridCell

//- (void) layoutSubviews {
//    UIView* view = self.visibleView;
//    
//    switch(self.visibleViewID)
//    {
//        case FLCellViewIDFirst:
//            [view setFrameOptimizedForLocation:FLRectCenterRectInRect(self.frame, [view frame])];
//        break;
//        
//        case FLCellViewIDSecond:
//            [view setFrameOptimizedForLocation:self.frame];
//        break;
//        
//        case FLCellViewIDThird:
//        break;
//    }
//}

//- (Class) viewClassForCellState:(FLGridCellState) state {
//    
//    switch(
//
//}
//
//- (UIView*) createViewForGridCellState:(FLGridCellState) visibleViewID {
//    switch(visibleViewID) {
//        case FLCellViewIDFirst:
//            return FLAutorelease([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
//        break;
//        
//        case FLCellViewIDSecond:
//        break;
//
//        case FLCellViewIDThird:
//        break;
//    }
//    
//    return nil;
//}

//- (void) cellWillChangeVisibleViewAnimated:(BOOL) animated
//                                data:(id) dataOrNil
//                  completionCallback:(dispatch_block_t) completionCallback;
//{
//    switch(self.visibleViewID)
//    {
//        case FLCellViewIDFirst:
//        {
//            UIActivityIndicatorView* progress = (UIActivityIndicatorView*) self.view;
//            progress.frame = FLRectCenterRectInRect(self.frame, progress.frame);
//            progress.hidden = NO;
//            [progress startAnimating];
//            completionCallback();
//        }
//        break;
//        
//        case FLCellViewIDSecond:
//        case FLCellViewIDThird:
//            completionCallback();
//        break;
//    }
//    
//        
//}

@end
