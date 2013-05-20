//
//	UIScrollView+GtExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtViewContentsDescriptor.h"

@interface UIScrollView (GtExtras)

- (CGRect) visibleRect;
- (void) scrollToTop:(BOOL) animated;
- (void) scrollToBottom:(BOOL) animated;
- (void) adjustInsets:(GtViewContentsDescriptor) contents;

@end
