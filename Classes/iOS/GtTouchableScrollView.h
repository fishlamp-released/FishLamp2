//
//	GtTouchableScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

@protocol GtTouchableScrollViewDelegate;

@interface GtTouchableScrollView : UIScrollView {
@private
	NSTimeInterval m_lastEventTimeStamp;
	id<GtTouchableScrollViewDelegate> m_touchDelegate;
}

@property (readwrite, assign, nonatomic) id<GtTouchableScrollViewDelegate> touchableScrollViewDelegate;

@end

@protocol GtTouchableScrollViewDelegate<NSObject>
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end