//
//	GtProgressPrototocl.h
//	ZenApi1.4
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "NSObject+GtTheme.h"

@class NSView;
@class NSViewController;

@protocol GtProgressProtocol <NSObject, GtThemedObject>
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) NSString* secondaryText;
@property (readwrite, retain, nonatomic) NSString* progressBarText;
@property (readwrite, retain, nonatomic) NSString* buttonTitle;
@property (readwrite, assign, nonatomic) NSTimeInterval startDelay;

- (void) setButtonTarget:(id)target 
                  action:(SEL) action
                isCancel:(BOOL) isCancel;

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount;

- (void) showProgress;
- (void) hideProgress;

- (void) setProgressViewAlpha:(float) alpha;

- (void) showProgressInSuperview:(UIView*) superview;
- (void) showProgressInViewController:(UIViewController*) viewController;


@end
