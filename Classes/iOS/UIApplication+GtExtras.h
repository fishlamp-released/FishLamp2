//
//	UIApplication+GtExtras.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface UIApplication (GtExtras) 

//- (void) openUrlInApp:(NSString*) url;

- (BOOL) openUrlInSafari:(NSURL*) url errorMessage:(NSString*) errorMessage;


@end