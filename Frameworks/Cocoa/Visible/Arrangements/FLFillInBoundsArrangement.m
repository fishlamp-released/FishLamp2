//
//  FLFillInBoundsArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFillInBoundsArrangement.h"

@implementation FLFillInBoundsArrangement

- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds {

	for(id object in objects) {
		if([object isHidden])  {
			continue;
		}
		
        bounds = [self setFrame:bounds forObject:object];
	}
    
    return bounds.size;
}

@end
