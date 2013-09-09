//
//	FLWebViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLViewController.h"
#import "FLLegacySimpleProgressView.h"
#import "FLProgressViewController.h"

@protocol FLWebViewControllerDelegate;

typedef enum {
    FLWebViewControllerButtonModeNone   = 0,

    FLWebViewControllerButtonModeNavigationButtonsOnTop    = (1 << 1),
    FLWebViewControllerButtonModeNavigationButtonsOnBottom = (1 << 2),
    
    FLWebViewControllerButtonModeCanCancel = (1 << 3)
} FLWebViewControllerButtonMode;

@interface FLWebViewController : FLViewController<UIWebViewDelegate> {
@private;
	IBOutlet UIWebView* _webView;
	IBOutlet UIBarButtonItem* _backButton;
	IBOutlet UIBarButtonItem* _forwardButton;
	IBOutlet UIBarButtonItem* _reloadButton;
	IBOutlet UIBarButtonItem* _actionButton;
	IBOutlet UIToolbar* _bottomToolbar;
    __unsafe_unretained id<FLWebViewControllerDelegate> _delegate;
	FLProgressViewController* _progress;
	NSURL* _startURL;
	struct {
		unsigned int openHttpLinksInSafari:1;
		unsigned int openLinksInNewViewController:1;
		unsigned int canLeaveCookiesBehind: 1;
        unsigned int autoSetTitle: 1;
        FLWebViewControllerButtonMode buttonMode: 4;
	} _webViewFlags;
}

- (id) initWithButtonMode:(FLWebViewControllerButtonMode) buttonMode;

+ (id) webViewController:(FLWebViewControllerButtonMode) buttonMode;

@property (readonly, assign, nonatomic) FLWebViewControllerButtonMode buttonMode;

@property (readwrite, assign, nonatomic) id<FLWebViewControllerDelegate> webViewDelegate;

@property (readonly, retain, nonatomic) NSURL* startURL;

@property (readwrite, assign, nonatomic) BOOL openLinksInNewViewController;
@property (readwrite, assign, nonatomic) BOOL openHttpLinksInSafari;
@property (readwrite, assign, nonatomic) BOOL autoSetTitle; 

@property (readonly, retain, nonatomic) UIWebView* webView;

@property (readonly, retain, nonatomic) NSString* currentLocationUrl;

@property (readonly, retain, nonatomic) UIBarButtonItem* actionButton;
@property (readonly, retain, nonatomic) UIToolbar* bottomToolbar;

- (void) beginLoadingURL:(NSURL*) url;

- (void) updateButtonStates;

- (IBAction) buttonClickBack:(id) sender;
- (IBAction) buttonClickForward:(id) sender;
- (IBAction) buttonClickReload:(id) sender;

+ (void) clearCookiesForDomain:(NSString*) domain; // eg facebook

// override points:
- (NSMutableURLRequest*) createURLRequestForURL:(NSURL*) url;

- (void) userDidCancel:(id) sender;

- (BOOL) openInSafari;
- (BOOL) openURLInSafari:(NSURL*) url;

- (BOOL) shouldNavigateToLink:(NSURL*) url;

@end

@protocol FLWebViewControllerDelegate <NSObject>
- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller;
@end