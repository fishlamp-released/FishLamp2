//
//  FLLeftJustifiedColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLLeftJustifiedColumnArrangement.h"

@implementation FLLeftJustifiedColumnArrangement 

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {

	FLPoint topLeft = FLRectGetTopLeft(bounds);
    
    CGFloat bottom = bounds.origin.y;

    CGFloat lastRight = 0;
	for(id object in objects) {
		if([object isHidden]) {
			continue;
		}
		
        FLRect frame = [object frameForObject:object];
        frame.origin = topLeft;
        
        frame = [self setFrame:frame forObject:object];
        
        // keep track of largest bottom (heh heh)
		bottom = MAX(bottom, FLRectGetBottom(frame));
	
        lastRight = FLRectGetRight(frame);
    
        // already move -x for the width of the object
        topLeft.x = lastRight; 
    }
    
    bounds.size.height = (bottom - bounds.origin.y);
    bounds.size.width = lastRight - bounds.origin.x;
    return bounds.size;
}
@end