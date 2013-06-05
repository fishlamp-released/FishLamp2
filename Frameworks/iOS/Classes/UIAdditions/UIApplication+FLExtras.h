//
//	UIApplication+FLExtras.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface UIApplication (FLExtras) 

//- (void) openUrlInApp:(NSString*) url;

- (BOOL) openUrlInSafari:(NSURL*) url errorMessage:(NSString*) errorMessage;

// this is the topmost visible viewcontroller as best as we can figure out.
// pays attention to container view (e.g. PLViewControllerStack, UINavigationController)
// and modally presented view controllers.
+ (UIViewController*) visibleViewController;

@end

//@interface UIViewController (FLApp)
//- (UINavigationController*) rootNavigationController;
//- (UIViewController*) visibleViewController;
//@end

