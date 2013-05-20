//
//	GtSimpleHtmlView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtSimpleHtmlViewDelegate;

@interface GtSimpleHtmlView : UIWebView<UIWebViewDelegate> {
@private
	UIActivityIndicatorView* m_spinner;
	id<GtSimpleHtmlViewDelegate> m_simpleHtmlViewDelegate;
	NSString* m_lastDocument;
	
	struct {
		unsigned int isLoaded:1;
		unsigned int isLoading:1; 
	} m_simpleHtmlFlags;
}

@property (readwrite, assign, nonatomic) id<GtSimpleHtmlViewDelegate> simpleHtmlViewDelegate;
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

@protocol GtSimpleHtmlViewDelegate <NSObject>
- (void) simpleHtmlView:(GtSimpleHtmlView*) view didFinishLoading:(NSError*) error;
@optional
- (void) simpleHtmlView:(GtSimpleHtmlView*) view configureRequest:(NSMutableURLRequest*) request;

- (void) simpleHtmlViewDidStartLoading:(GtSimpleHtmlView*) view;

- (BOOL) simpleHtmlView:(GtSimpleHtmlView *)view 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType;
@end