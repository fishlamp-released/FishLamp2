//
//  FLRightJustifiedColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLRightJustifiedColumnArrangement.h"

@implementation FLRightJustifiedColumnArrangement 

- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds {

	SDKPoint topRight = FLRectGetTopRight(bounds);
   
    CGFloat bottom = bounds.origin.y ;

	for(id object in objects.reverseObjectEnumerator) {
		if([object isHidden]) {
			continue;
		}
		
        SDKRect frame = [self frameForObject:object];
        
        topRight.x -= frame.size.width;
	
        frame = [self setFrame:frame forObject:object];

        bottom = MAX(bottom, FLRectGetBottom(frame));
    }
    
    bounds.size.height = (bottom - bounds.origin.y);
    return bounds.size;
}


@end