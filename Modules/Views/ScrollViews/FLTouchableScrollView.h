//
//	FLTouchableScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLTouchableScrollViewDelegate;

@interface FLTouchableScrollView : UIScrollView {
@private
	NSTimeInterval _lastEventTimeStamp;
	id<FLTouchableScrollViewDelegate> _touchDelegate;
}

@property (readwrite, assign, nonatomic) id<FLTouchableScrollViewDelegate> touchableScrollViewDelegate;

@end

@protocol FLTouchableScrollViewDelegate<NSObject>
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end