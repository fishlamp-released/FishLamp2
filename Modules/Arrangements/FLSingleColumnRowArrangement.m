//
//  FLSingleRowColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSingleColumnRowArrangement.h"

@implementation FLSingleColumnRowArrangement

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {

	CGFloat top = bounds.origin.y;
    
	for(id object in objects) {	
		if([object isHidden])  {
			continue;
		}
        
        FLRect frame = [self arrangeableFrameForObject:object];
        frame.origin = FLPointMake(bounds.origin.x, top);
        frame.size = FLSizeMake(bounds.size.width, frame.size.height);

        frame = [self setArrangeableFrame:frame forObject:object];
                
//        FLSize size = [object calculateSizeInArrangementSize:FLSizeMake(width, [object frame].size.height) hint:[object arrangeableFillMode]];
//        
//        setFrame(object, FLRectMake(left, top, size.width, size.height));
					
		top = FLRectGetBottom(frame);
    }
    
	return CGSizeMake(bounds.size.width, top - bounds.origin.y);
}

@end
