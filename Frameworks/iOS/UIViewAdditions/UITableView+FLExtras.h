//
//	UITableView+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "UIScrollView+FLExtras.h"

@interface UITableView (FLTableView)
- (CGFloat) calculateTotalHeight;
@end

@interface UITableViewCell (FLExtras)
+ (void) drawDisclosureArrowInRect:(CGRect) rect 
	color:(UIColor*) color 
	alpha:(CGFloat) alpha
	context:(CGContextRef) context;
@end

