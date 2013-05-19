//
//  FLSimpleHtmlViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLViewController.h"
#import "FLSimpleHtmlView.h"
#import "NSURLRequest+HTTP.h"

@interface FLSimpleHtmlViewController : FLViewController<FLSimpleHtmlViewDelegate> {
@private
	FLErrorCallback _finishLoadingCallback;
	FLMutableURLRequestCallback _configureRequestCallback;
	FLSimpleHtmlView* _htmlView;
}

@property (readwrite, copy, nonatomic) FLErrorCallback finishedLoadingCallback;
@property (readwrite, copy, nonatomic) FLMutableURLRequestCallback configureRequestCallback;
  
@property (readonly, retain, nonatomic) FLSimpleHtmlView* htmlView; // enclosed in the root view, so it can be moved.

- (void) beginLoadingHtmlStringDocument:(NSString*) document
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

- (void) beginLoadingUrl:(NSURL*) url
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

@end
