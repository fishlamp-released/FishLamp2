//
//	UITableView+GtExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "UIScrollView+GtExtras.h"

@interface UITableView (GtTableView)
- (CGFloat) calculateTotalHeight;
@end

@interface UITableViewCell (GtExtras)
+ (void) drawDisclosureArrowInRect:(CGRect) rect 
	color:(UIColor*) color 
	alpha:(CGFloat) alpha
	context:(CGContextRef) context;
@end

