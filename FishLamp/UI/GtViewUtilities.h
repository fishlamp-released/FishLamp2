//
//  GtViewUtilities.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

/*
@protocol GtViewControllerProtocol<NSObject>
	- (void) closeSelf;
@end

typedef enum 
{
	gtNoTransition = gtBit0,
	
	gtFade = gtBit1,
	gtMove = gtBit2,
	gtPush = gtBit3,
	gtReveal = gtBit4,
	
	gtSlideInFromBottom = gtBit5,
	gtSlideInFromLeft = gtBit6,
	gtSlideInFromRight = gtBit7,
	gtSlideInFromTop = gtBit8,
	gtFlipIn = gtBit9
	
} GtTransitionType;
*/
@interface GtViewUtilities : NSObject {
//	NSMutableArray* m_stack;
}


/*
- (void) animateViewTransition:(GtTransitionType) showType
	parentView:(UIView*) parentView
	child:(UIViewController*) child
	show:(BOOL) show;
*/

+ (void) createRoundRectPath:(CGRect) rect cornerRadius:(CGFloat) cornerRadius outPath:(CGPathRef*) outPath;

/*

// THIS IS A HACK - SHOULDN'T NEED THIS
- (void) removeCurrentSubView:(UIView*) parent;
- (void) restoreCurrentSubView;
*/

+ (CGRect) rotatedDeviceBounds;

+ (CGRect) rotatedFrameForView:(UIView*) view;

@end


#endif