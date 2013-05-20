//
//  GtPhotoView.h
//  MyZen
//
//  Created by Mike Fullerton on 11/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG
#define LOG_PHOTO_VIEW 0
#endif

#import "GtCallback.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"

#import "GtActionContext.h"
#import "GtViewController.h"
#import "GtWeakReference.h"
#import "GtImageView.h"

@interface GtPhotoView : GtImageView {
	id m_photo;
	id m_userData;
    UIActivityIndicatorView* m_spinner;
	GtWeakReference* m_detailsView;
	GtWeakReference* m_action;
	UIView* m_errorView;
    UIButton* m_retryButton;
    NSString* m_title;
	NSString* m_details;
    
    struct {
        unsigned int isLoading:1;
        unsigned int isLoaded:1;
        unsigned int cancelled:1;
        unsigned int failedToLoad:1;
    } m_photoViewFlags;
}

@property (readwrite, assign, nonatomic) GtNotificationView* detailsView;
@property (readwrite, assign, nonatomic) NSString* title;
@property (readwrite, assign, nonatomic) NSString* details;

@property (readwrite, assign, nonatomic) UIActivityIndicatorView* spinner;
@property (readwrite, assign, nonatomic) id photo;
@property (readwrite, assign, nonatomic) id userData;
@property (readwrite, assign, nonatomic) GtAction* action;

@property (readwrite, assign, nonatomic) BOOL isLoaded;
@property (readwrite, assign, nonatomic) BOOL isLoading;
@property (readonly, assign, nonatomic) BOOL cancelled;
@property (readwrite, assign, nonatomic) BOOL failedToLoad;
@property (readonly, assign, nonatomic) BOOL hasDetailsView;

- (void) cancel;

- (void) setFailedToLoad:(id) target retryAction:(SEL) retry;
- (void) reset;

- (void) startSpinner;
- (void) stopSpinner;
       
- (void) hideDetailsView;
- (void) showDetailsView:(BOOL) showIfEmpty withMessage:(NSString*) message;


@end
