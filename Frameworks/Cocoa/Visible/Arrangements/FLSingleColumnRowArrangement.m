//
//  FLSingleRowColumnArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSingleColumnRowArrangement.h"

@implementation FLSingleColumnRowArrangement

- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds {

	CGFloat top = bounds.origin.y;
    
	for(id object in objects) {	
		if([object isHidden])  {
			continue;
		}
        
        SDKRect frame = [object frameForObject:object];
        frame.origin = FLPointMake(bounds.origin.x, top);
        frame.size = FLSizeMake(bounds.size.width, frame.size.height);

        [object setArrangeableFrame:frame];
        
                        
//        SDKSize size = [object calculateSizeInArrangementSize:FLSizeMake(width, [object frame].size.height) hint:[object arrangeableGrowMode]];
//        
//        setFrame(object, FLRectMake(left, top, size.width, size.height));
					
		top = FLRectGetBottom([object arrangeableFrame]);
    }
    
	return FLSizeMake(bounds.size.width, top - bounds.origin.y);
}

@end
