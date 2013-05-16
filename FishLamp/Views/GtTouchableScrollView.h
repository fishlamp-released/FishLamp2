//
//  GtTouchableScrollView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/26/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GtTouchableScrollViewTouchResponder;

@interface GtTouchableScrollView : UIScrollView {
@private
	NSTimeInterval m_lastEventTimeStamp;
}

@end

/**
optionally implement these in your scrollBar delegate to respond to them.
*/

@protocol GtTouchableScrollViewDelegate<NSObject>
@optional
- (BOOL) touchableScrollView:(GtTouchableScrollView*) scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(GtTouchableScrollView*) scrollView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(GtTouchableScrollView*) scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) touchableScrollView:(GtTouchableScrollView*) scrollView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end