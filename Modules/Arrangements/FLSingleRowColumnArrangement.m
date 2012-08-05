//
//  FLColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSingleRowColumnArrangement.h"

@implementation FLSingleRowColumnArrangement

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                         inBounds:(FLRect) bounds {
	
    CGFloat colWidth = bounds.size.width;

	id adjustableView = nil;
	for(id object in objects) {
		if([object isHidden]) {
			continue;
		}
		
        if([object arrangeableFillMode] == FLArrangeableFillModeFlexibleWidth) {
			FLAssert(adjustableView == nil, @"only one flexible object supported");
			adjustableView = object;
		}
        else {
            colWidth -= [self arrangeableFrameForObject:object].size.width;
        }
	}
		
	CGPoint origin = bounds.origin;
    
    CGFloat bottom = bounds.origin.y;

	for(id object in objects) {
		if([object isHidden]) {
			continue;
		}
		
		FLRect frame = [self arrangeableFrameForObject:object];
        
        frame.origin = origin;
        
        if(object == adjustableView) {
            frame.size.width = colWidth;
        }
        
        frame = [self setArrangeableFrame:frame forObject:object];
	
        bottom = MAX(bottom, FLRectGetBottom(frame));
		origin.x += frame.size.width;
	}
    
    bounds.size.height = (bottom - bounds.origin.y);
    bounds.size.width = origin.x;
    return bounds.size;
}
@end
