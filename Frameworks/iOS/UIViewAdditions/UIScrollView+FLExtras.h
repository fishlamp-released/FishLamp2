//
//	UIScrollView+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLViewContentsDescriptor.h"

@interface UIScrollView (FLExtras)

- (CGRect) visibleRect;
- (void) scrollToTop:(BOOL) animated;
- (void) scrollToBottom:(BOOL) animated;
//- (void) adjustInsets:(FLViewContentsDescriptor*) contents;

@end
