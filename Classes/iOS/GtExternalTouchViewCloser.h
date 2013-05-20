//
//  GtExternalTouchViewCloser.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtApplication.h"

@protocol GtExternalTouchViewCloserDelegate;

@interface GtExternalTouchViewCloser :  NSObject<GtEventInterceptor> {
@private
    NSMutableArray* m_views;
    NSMutableArray* m_passThroughViews;
    UIView* m_touchedView;
    BOOL m_touchIsInside;
    id<GtExternalTouchViewCloserDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtExternalTouchViewCloserDelegate> delegate;

+ (GtExternalTouchViewCloser*) externalTouchViewCloser;

- (void) addPrimaryView:(UIView*) view;

- (void) addPassthroughView:(UIView*) view;

- (void) beginWatchingTouchesForView:(UIView*) view;
- (void) stopWatchingTouches;

@end

@protocol GtExternalTouchViewCloserDelegate <NSObject>
- (void) externalTouchViewCloserShouldCloseView:(GtExternalTouchViewCloser*) closer;
@end