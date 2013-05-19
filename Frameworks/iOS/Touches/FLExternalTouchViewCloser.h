//
//  FLExternalTouchViewCloser.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLApplication.h"

@protocol FLExternalTouchViewCloserDelegate;

@interface FLExternalTouchViewCloser :  NSObject<FLApplicationEventInterceptor> {
@private
    NSMutableArray* _views;
    NSMutableArray* _passThroughViews;
    UIView* _touchedView;
    BOOL _touchIsInside;
    __unsafe_unretained id<FLExternalTouchViewCloserDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLExternalTouchViewCloserDelegate> delegate;

+ (FLExternalTouchViewCloser*) externalTouchViewCloser;

- (void) addPrimaryView:(UIView*) view;

- (void) addPassthroughView:(UIView*) view;

- (void) beginWatchingTouchesForView:(UIView*) view;
- (void) stopWatchingTouches;

@end

@protocol FLExternalTouchViewCloserDelegate <NSObject>
- (void) externalTouchViewCloserShouldCloseView:(FLExternalTouchViewCloser*) closer;
@end