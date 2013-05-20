//
//	GtViewAnimatorProtocol.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@protocol GtViewAnimatorProtocol <NSObject>

- (void) addSubview:(UIView*) view 
		  superview:(UIView*) superview;
		  
- (void) removeFromSuperview:(UIView*) view;

- (void) insertSubview:(UIView*) view 
			   atIndex:(NSInteger)idx 
			superview:(UIView*) superview;

/* doesn't insert/remove from superview */
- (void) showView:(UIView*) view;
- (void) hideView:(UIView*) view;

@end
