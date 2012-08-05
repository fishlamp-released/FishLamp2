//
//  FLRightJustifiedColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLRightJustifiedColumnArrangement.h"

@implementation FLRightJustifiedColumnArrangement 

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {

	CGPoint topRight = FLRectGetTopRight(bounds);
   
    CGFloat bottom = bounds.origin.y ;

	for(id object in objects.reverseObjectEnumerator) {
		if([object isHidden]) {
			continue;
		}
		
        FLRect frame = [self arrangeableFrameForObject:object];
        
        topRight.x -= frame.size.width;
	
        frame = [self setArrangeableFrame:frame forObject:object];

        bottom = MAX(bottom, FLRectGetBottom(frame));
    }
    
    bounds.size.height = (bottom - bounds.origin.y);
    return bounds.size;
}


@end