//
//	GtNotificationView.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRoundRectView.h"
#import "GtHtmlBuilder.h"
#import "GtSimpleHtmlView.h"
#import "UIView+ViewAnimation.h"
#import "GtAutoLayoutViewController.h"

#define GtDefaultAutoCloseDelay 8.0

#define GtNotificationViewShowDelay 0.5

@protocol GtNotificationViewDelegate;

typedef enum {
	GtNotificationViewStyleRoundedCorners,
	GtNotificationViewStyleSquareCorners
} GtNotificationViewStyle;

typedef enum {
	GtNotificationViewDismissStyleNone,
	GtNotificationViewDismissStyleCloseBox,
	GtNotificationViewDismissStyleTapAnywhere
} GtNotificationViewDismissStyle;

@interface GtNotificationView : UIView<GtSimpleHtmlViewDelegate> {
@private
	
// state objects
	NSString* m_text;
	UIColor* m_textColor;
	NSString* m_title;
	UIColor* m_oldBackgroundColor;
	UIColor* m_oldTextColor;
	GtRoundRectView* m_roundRectView;
	
// subviews	   
	UIButton* m_closeButton;
	UIImageView* m_iconView;
	UILabel* m_titleLabel;
	GtSimpleHtmlView* m_htmlView;
	UILabel* m_textView;
	UILabel* m_timeLabel;
	UIImageView* m_closeBoxImageView; 
	UILabel* m_closeBoxX;
	
// aliased	
	NSTimer* m_timer;
	id<GtNotificationViewDelegate> m_notificationViewDelegate;
	
// data
	CGFloat m_shouldAutoCloseAfterDelayDelay;
	CGFloat m_maxHeight;
	CGFloat m_showDelay;
	
	NSTimeInterval m_shownTimestamp;
	CGFloat m_padding;
	
	struct {
		GtNotificationViewDismissStyle dismissStyle: 2;
		unsigned int isHtml: 1;
		unsigned int notifiedWasTouched:1;
		GtViewAnimationType animationType:4;
		unsigned int disableAutoClose:1;
		unsigned int isModal:1;
		unsigned int created:1;
		unsigned int shouldAutoCloseAfterDelay:1;
		unsigned int textNeedsUpdate:1;
		GtNotificationViewStyle notificationViewStyle:2; 
	} m_notificationViewFlags;
	
}

@property (readwrite, assign, nonatomic) id<GtNotificationViewDelegate> notificationViewDelegate;

@property (readwrite, assign, nonatomic) CGFloat padding;
@property (readwrite, assign, nonatomic) GtViewAnimationType animationType;
@property (readwrite, assign, nonatomic) GtNotificationViewDismissStyle dismissStyle;
@property (readwrite, assign, nonatomic) BOOL isHtml;
@property (readwrite, assign, nonatomic) BOOL shouldAutoCloseAfterDelay;
@property (readwrite, assign, nonatomic) GtNotificationViewStyle notificationViewStyle;
@property (readwrite, assign, nonatomic) CGFloat showDelay;
@property (readwrite, assign, nonatomic) CGFloat shouldAutoCloseAfterDelayDelay;
@property (readwrite, assign, nonatomic) CGFloat maxTextHeight;

@property (readonly, retain, nonatomic) GtRoundRectView* roundRectView;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) UIColor* textColor;
@property (readwrite, retain, nonatomic) UIImageView* iconView;

@property (readonly, assign, nonatomic) NSTimeInterval shownTimestamp;

- (void) hideNotification;
@end

@protocol GtNotificationViewDelegate <NSObject>
@optional
- (void) notificationViewWasTouched:(GtNotificationView*) view;
- (void) notificationViewDidShow:(GtNotificationView*) view;
- (void) notificationViewWillHide:(GtNotificationView*) view;
- (void) notificationViewUserClosed:(GtNotificationView*) view;
@end

@interface GtNotificationViewController : GtAutoLayoutViewController
@property (readonly, retain, nonatomic) GtNotificationView* notificationView;

- (id) initWithNotificationView:(GtNotificationView*) view;
+ (id) notificationViewController:(GtNotificationView*) view;

- (void) showNotification;
- (void) hideNotification;

//show view when parent view controller of view controller becomes visible. If viewControllerOrNil is nil, it will use global notification host.

- (void) showNotificationInViewController:(GtViewController*) viewControllerOrNil;

- (void) showDeferredNotificationInViewController:(GtViewController*) viewControllerOrNil;
@end