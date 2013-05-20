//
//  GtWidget+Touches.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/28/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#if 0
#import "GtWidget.h"

@interface GtWidget (Touches) <GtEventInterceptor>
@property (readwrite, assign, nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic) BOOL highlightOnTouch;   // defaults to YES
@property (readwrite, assign, nonatomic) BOOL exclusiveTouchMode; // defaults to YES
@property (readonly, assign, nonatomic) BOOL touchDidEnter;
@property (readwrite, assign, nonatomic) BOOL didChangeStateOnTouch;

- (void) resetTouchState;
- (void) cancelCurrentTouch;
+ (id) touchedWidget; // non-nil during touch events, and its the widget that gets the initial touchStart event.
+ (id) lastEnteredWidget;
@end
#endif