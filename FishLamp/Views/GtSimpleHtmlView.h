//
//  GtSimpleHtmlView.h
//  MyZen
//
//  Created by Mike Fullerton on 1/26/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtHtmlBuilder.h"
#import "GtSimpleCallback.h"

@interface GtSimpleHtmlView : UIWebView<UIWebViewDelegate> {
	GtHtmlBuilder* m_builder;
    UIActivityIndicatorView* m_spinner;
    CGSize m_loadedSize;
    GtSimpleCallback* m_loadedCallback;
    NSError* m_error;
    struct {
        unsigned int isLoaded:1;
    } m_simpleHtmlFlags;
}

@property (readonly, assign, nonatomic) CGSize loadedSize;
@property (readonly, assign, nonatomic) BOOL isLoaded;
@property (readonly, assign, nonatomic) NSError* loadError;
@property (readonly, assign, nonatomic) GtHtmlBuilder* html;

- (void) setLoadedCallback:(id) target action:(SEL) action;

- (void) setIsTransparent;
    // NOTE: callAddStyleClearBackgroundColor in body style element

- (void) renderHtml;

@end
