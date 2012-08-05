//
//  FLWidget+Touches.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/28/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#if 0
#import "FLWidget.h"

@interface FLWidget (Touches) <FLEventInterceptor>
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