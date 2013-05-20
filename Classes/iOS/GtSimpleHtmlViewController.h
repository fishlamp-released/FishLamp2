//
//  GtSimpleHtmlViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtViewController.h"
#import "GtSimpleHtmlView.h"
#import "NSURLRequest+HTTP.h"

@interface GtSimpleHtmlViewController : GtViewController<GtSimpleHtmlViewDelegate> {
@private
	GtErrorCallback m_finishLoadingCallback;
	GtMutableURLRequestCallback m_configureRequestCallback;
	GtSimpleHtmlView* m_htmlView;
}

@property (readwrite, copy, nonatomic) GtErrorCallback finishedLoadingCallback;
@property (readwrite, copy, nonatomic) GtMutableURLRequestCallback configureRequestCallback;
  
@property (readonly, retain, nonatomic) GtSimpleHtmlView* htmlView; // enclosed in the root view, so it can be moved.

- (void) beginLoadingHtmlStringDocument:(NSString*) document
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

- (void) beginLoadingUrl:(NSURL*) url
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

@end
