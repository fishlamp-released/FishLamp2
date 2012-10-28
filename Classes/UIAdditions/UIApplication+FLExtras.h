//
//	UIApplication+FLExtras.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
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

