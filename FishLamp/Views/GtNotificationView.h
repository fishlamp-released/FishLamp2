//
//  GtNotificationView.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtRoundRectView.h"
#import "GtEventEaterView.h"
#import "GtWeakReference.h"
#import "GtHtmlBuilder.h"
#import "GtWindow.h"
#import "GtSimpleHtmlView.h"
#import "GtViewAnimator.h"

#define GT_AUTO_DISMISS_INTERVAL 8.0

typedef enum {
	GtNotificationViewLocationCentered,
	GtNotificationViewLocationBottom,
	GtNotificationViewLocationBottomAboveToolBar,
	GtNotificationViewLocationBottomAboveTabBar,
	GtNotificationViewLocationTop
} GtNotificationViewLocation;

typedef enum { 
    GtNotificationViewAnimationTypeSlide,
    GtNotificationViewAnimationTypeFade
} GtNotificationViewAnimationType;

@interface GtNotificationView : GtRoundRectView<GtWeaklyReferencedObject, GtWebViewTouchDelegate> {
@private
	
// retained	
	UIView* m_customView;
	UIColor* m_textColor;
	UIImage* m_icon;
	GtHtmlBuilder* m_text;
	NSString* m_title;
	NSString* m_errorCode;
    UIColor* m_oldBackgroundColor;
    UIColor* m_oldTextColor;
    
    UIButton* m_closeBox;
    UIImageView* m_iconView;
    UILabel* m_titleLabel;
    
    GtSimpleHtmlView* m_htmlView;
    UILabel* m_textView;
    UILabel* m_timeLabel;
    UILabel* m_errorLabel;
    GtEventEaterView* m_shieldView;
    
    id<GtViewAnimatorProtocol> m_viewAnimator;
    
// aliased	
	NSTimer* m_timer;
	id m_delegate;
    
// data
	CGFloat m_autoCloseDelay;
	CGFloat m_customLocation;
    NSUInteger m_maxHeight;

    struct {
        unsigned int isModal: 1;
        unsigned int canDismiss: 1;
        unsigned int isHtml: 1;
        unsigned int notifiedWasTouched:1;
        unsigned int location:4;
        unsigned int visible:1;
        unsigned int animationType:2;
    } m_notificationViewFlags;
    

    GtDeclareWeakRefMember();
}

@property (readwrite,   assign, nonatomic) id delegate;

@property (readwrite,   assign, nonatomic) GtNotificationViewAnimationType animationType;
@property (readwrite, 	assign, nonatomic) BOOL isModal;
@property (readwrite, 	assign, nonatomic) BOOL canDismiss;
@property (readwrite,   assign, nonatomic) BOOL isHtml;
@property (readwrite,   assign, nonatomic) NSUInteger maxTextHeight;


@property (readwrite, 	assign, nonatomic) NSString* title;
@property (readonly, 	assign, nonatomic) GtHtmlBuilder* text;
@property (readwrite, 	assign, nonatomic) NSString* errorCode;

@property (readwrite, 	assign, nonatomic) CGFloat autoCloseDelay;

@property (readwrite, 	assign, nonatomic) GtNotificationViewLocation location;
@property (readwrite, 	assign, nonatomic) CGFloat customLocation;

@property (readwrite, 	assign, nonatomic) UIView* customView;

@property (readwrite, 	assign, nonatomic) UIColor* color;
@property (readwrite, 	assign, nonatomic) UIColor* textColor;
@property (readwrite, 	assign, nonatomic) UIImage* icon;

- (void) setErrorCodeWithInteger:(NSInteger) errorCode;
- (void) show;
- (void) hide;

+ (UIView*) defaultSuperview;

- (void) showInDefaultWindow;


// deprecated, use hide
- (void) close;
@end

@protocol GtNotificationViewDelegate <NSObject>

- (void) notificationViewWasTouched:(GtNotificationView*) view;

@end