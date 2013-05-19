//
//	FLOldNotificationView.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRoundRectView.h"
#import "FLHtmlStringBuilder.h"
#import "FLSimpleHtmlView.h"
#import "UIView+ViewAnimation.h"

#define FLDefaultAutoCloseDelay 8.0

#define FLOldNotificationViewShowDelay 0.5

@protocol FLOldNotificationViewDelegate;

typedef enum {
	FLOldNotificationViewStyleRoundedCorners,
	FLOldNotificationViewStyleSquareCorners
} FLOldNotificationViewStyle;

typedef enum {
	FLOldNotificationViewDismissStyleNone,
	FLOldNotificationViewDismissStyleCloseBox,
	FLOldNotificationViewDismissStyleTapAnywhere
} FLOldNotificationViewDismissStyle;

@interface FLOldNotificationView : UIView<FLSimpleHtmlViewDelegate> {
@private
	
// state objects
	NSString* _text;
	UIColor* _textColor;
	NSString* _title;
	UIColor* _oldBackgroundColor;
	UIColor* _oldTextColor;
	FLRoundRectView* _roundRectView;
	
// subviews	   
	UIButton* _closeButton;
	UIImageView* _iconView;
	UILabel* _titleLabel;
	FLSimpleHtmlView* _htmlView;
	UILabel* _textView;
	UILabel* _timeLabel;
	UIImageView* _closeBoxImageView; 
	UILabel* _closeBoxX;
	
// aliased	
	__unsafe_unretained NSTimer* _timer;
	__unsafe_unretained id<FLOldNotificationViewDelegate> _notificationViewDelegate;
	
// data
	CGFloat _shouldAutoCloseAfterDelayDelay;
	CGFloat _maxHeight;
	CGFloat _showDelay;
	
	NSTimeInterval _shownTimestamp;
	CGFloat _padding;
	
	struct {
		FLOldNotificationViewDismissStyle dismissStyle: 2;
		unsigned int isHtml: 1;
		unsigned int notifiedWasTouched:1;
		FLAnimatedViewType animationType:4;
		unsigned int disableAutoClose:1;
		unsigned int isModal:1;
		unsigned int created:1;
		unsigned int shouldAutoCloseAfterDelay:1;
		unsigned int textNeedsUpdate:1;
		FLOldNotificationViewStyle notificationViewStyle:2; 
	} _notificationViewFlags;
	
}

@property (readwrite, assign, nonatomic) id<FLOldNotificationViewDelegate> notificationViewDelegate;

@property (readwrite, assign, nonatomic) CGFloat padding;
@property (readwrite, assign, nonatomic) FLAnimatedViewType animationType;
@property (readwrite, assign, nonatomic) FLOldNotificationViewDismissStyle dismissStyle;
@property (readwrite, assign, nonatomic) BOOL isHtml;
@property (readwrite, assign, nonatomic) BOOL shouldAutoCloseAfterDelay;
@property (readwrite, assign, nonatomic) FLOldNotificationViewStyle notificationViewStyle;
@property (readwrite, assign, nonatomic) CGFloat showDelay;
@property (readwrite, assign, nonatomic) CGFloat shouldAutoCloseAfterDelayDelay;
@property (readwrite, assign, nonatomic) CGFloat maxTextHeight;

@property (readonly, retain, nonatomic) FLRoundRectView* roundRectView;
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) NSString* text;
@property (readwrite, retain, nonatomic) UIColor* textColor;
@property (readwrite, retain, nonatomic) UIImageView* iconView;

@property (readonly, assign, nonatomic) NSTimeInterval shownTimestamp;

- (void) hideNotification;
@end

@protocol FLOldNotificationViewDelegate <NSObject>
@optional
- (void) notificationViewWasTouched:(FLOldNotificationView*) view;
- (void) notificationViewDidShow:(FLOldNotificationView*) view;
- (void) notificationViewWillHide:(FLOldNotificationView*) view;
- (void) notificationViewUserClosed:(FLOldNotificationView*) view;
@end