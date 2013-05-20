//
//	GtWebViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtViewController.h"
#import "GtOldProgressView.h"
#import "GtProgressViewOwner.h"

@protocol GtWebViewControllerDelegate;

typedef enum {
    GtWebViewControllerButtonModeNone   = 0,

    GtWebViewControllerButtonModeNavigationButtonsOnTop    = (1 << 1),
    GtWebViewControllerButtonModeNavigationButtonsOnBottom = (1 << 2),
    
    GtWebViewControllerButtonModeCanCancel = (1 << 3)
} GtWebViewControllerButtonMode;

@interface GtWebViewController : GtViewController<UIWebViewDelegate> {
@private;
	IBOutlet UIWebView* m_webView;
	IBOutlet UIBarButtonItem* m_backButton;
	IBOutlet UIBarButtonItem* m_forwardButton;
	IBOutlet UIBarButtonItem* m_reloadButton;
	IBOutlet UIBarButtonItem* m_actionButton;
	IBOutlet UIToolbar* m_bottomToolbar;
	GtProgressViewOwner* m_spinner;
	NSURL* m_startURL;
	NSString* m_anchor;
	
    id<GtWebViewControllerDelegate> m_delegate;
    
	struct {
		unsigned int openHttpLinksInSafari:1;
		unsigned int openLinksInNewViewController:1;
		unsigned int canLeaveCookiesBehind: 1;
        unsigned int autoSetTitle: 1;
        GtWebViewControllerButtonMode buttonMode: 4;
	} m_webViewFlags;
}

- (id) initWithButtonMode:(GtWebViewControllerButtonMode) buttonMode;

+ (id) webViewController:(GtWebViewControllerButtonMode) buttonMode;

@property (readonly, assign, nonatomic) GtWebViewControllerButtonMode buttonMode;

@property (readwrite, assign, nonatomic) id<GtWebViewControllerDelegate> webViewDelegate;

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

@protocol GtWebViewControllerDelegate <NSObject>
- (void) webViewControllerUserDidCancel:(GtWebViewController*) controller;
@end