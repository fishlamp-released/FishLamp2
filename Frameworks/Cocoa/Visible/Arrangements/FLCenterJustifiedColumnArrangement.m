//
//  FLCenterJustifiedColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCenterJustifiedColumnArrangement.h"


@implementation FLCenterJustifiedColumnArrangement 

- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds {

    SDKSize size = [super layoutArrangeableObjects:objects inBounds:bounds];
    size.width = bounds.size.width;

    // find right side of last visible object, we'll shift all
    // the objects to the right.
	CGFloat right = 0;
    for(id object in objects.reverseObjectEnumerator) {
		if([object isHidden]) {
			continue;
		}
        
		right = FLRectGetRight([self frameForObject:object]);
        break;
    }
    
    if(right < size.width) {
        CGFloat offset = (size.width - right) / 2.0f;
        for(id object in objects) {
            if([object isHidden]) {
                continue;
            }
            
            [self setFrame:FLRectMoveHorizontally([self frameForObject:object], offset)
                            forObject:object];
        }
    }
    
    return size;
}


@end