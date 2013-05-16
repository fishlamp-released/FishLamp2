//
//  GtWindow.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GtDeviceWasShakenNotification @"SHAKEN"

@protocol GtWebViewTouchDelegate <NSObject>
- (void) webViewTouchesBegan:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) webViewTouchesMoved:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) webViewTouchesEnded:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) webViewTouchesCancelled:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) webViewTouchesStationaryTouch:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface GtWindow : UIWindow {
@private
	GtWindow* m_prevWindow;
    id<GtWebViewTouchDelegate> m_viewController;
    UIWebView* m_webView;
}

- (void) startObservingWebView:(id<GtWebViewTouchDelegate>) controller 
    forWebView:(UIWebView*) webview;

- (void) stopObservingWebView;

+ (GtWindow*) topWindow;

@end


