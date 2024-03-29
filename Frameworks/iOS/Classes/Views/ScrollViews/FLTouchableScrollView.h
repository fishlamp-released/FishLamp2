//
//	FLTouchableScrollView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

@protocol FLTouchableScrollViewDelegate;

@interface FLTouchableScrollView : UIScrollView {
@private
	NSTimeInterval _lastEventTimeStamp;
	__unsafe_unretained id<FLTouchableScrollViewDelegate> _touchDelegate;
}

@property (readwrite, assign, nonatomic) id<FLTouchableScrollViewDelegate> touchableScrollViewDelegate;

@end

@protocol FLTouchableScrollViewDelegate<NSObject>
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(UIScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end