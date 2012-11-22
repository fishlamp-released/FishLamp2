//
//	UITableView+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIScrollView+FLExtras.h"

@interface UITableView (FLTableView)
- (CGFloat) calculateTotalHeight;
@end

@interface UITableViewCell (FLExtras)
+ (void) drawDisclosureArrowInRect:(FLRect) rect 
	color:(UIColor*) color 
	alpha:(CGFloat) alpha
	context:(CGContextRef) context;
@end

