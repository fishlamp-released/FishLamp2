//
//	FLSimpleHtmlView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol FLSimpleHtmlViewDelegate;

@interface FLSimpleHtmlView : UIWebView<UIWebViewDelegate> {
@private
	UIActivityIndicatorView* _spinner;
	__unsafe_unretained id<FLSimpleHtmlViewDelegate> _simpleHtmlViewDelegate;
	NSString* _lastDocument;
	
	struct {
		unsigned int isLoaded:1;
		unsigned int isLoading:1; 
	} _simpleHtmlFlags;
}

@property (readwrite, assign, nonatomic) id<FLSimpleHtmlViewDelegate> simpleHtmlViewDelegate;
@property (readonly, assign, nonatomic) BOOL isLoaded;
@property (readonly, assign, nonatomic) BOOL isLoading;

- (void) setIsTransparent;
	// NOTE: callAddStyleClearBackgroundColor in body style element

- (void) beginLoadingHtmlStringDocument:(NSString*) document
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

- (void) beginLoadingUrl:(NSURL*) url
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle;

- (void) setSizeToLoadedSizeWithMaxSize:(CGSize) maxSize;

- (void) startSpinner:(UIActivityIndicatorViewStyle) style;
- (void) stopSpinner;

@end

@protocol FLSimpleHtmlViewDelegate <NSObject>
- (void) simpleHtmlView:(FLSimpleHtmlView*) view didFinishLoading:(NSError*) error;
@optional
- (void) simpleHtmlView:(FLSimpleHtmlView*) view configureRequest:(NSMutableURLRequest*) request;

- (void) simpleHtmlViewDidStartLoading:(FLSimpleHtmlView*) view;

- (BOOL) simpleHtmlView:(FLSimpleHtmlView *)view 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType;
@end