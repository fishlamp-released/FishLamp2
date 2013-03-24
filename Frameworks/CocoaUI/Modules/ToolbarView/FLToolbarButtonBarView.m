//
//	FLNavigationControllerButtonbarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if IOS
#import "FLToolbarButtonbarView.h"
#import "FLGradientButton.h"

@implementation FLToolbarButtonbarView

- (id) initWithFrame:(CGRect) frame {
	if((self = [super initWithFrame:frame])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	}

	return self;
}

- (void) willMoveToSuperview:(SDKView *)newSuperview
{
	[super willMoveToSuperview:newSuperview];
	if(newSuperview)
	{
		self.frame = newSuperview.bounds;
	}
}

- (void) setFrame:(CGRect) frame
{
	FLLog(@"setting frame: %@", NSStringFromCGRect(frame));

	if(frame.origin.x <= 8.0) 
	{
		frame.size.width += frame.origin.x;
		frame.origin.x = 0; 
	}
	
	[super setFrame:frame];
}

//- (void) layoutSubviews
//{
//	  [super layoutSubviews];
////	self.newFrame = self.superview.bounds;
//	  
//	  
//}

@end


#endif