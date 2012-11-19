//
//  FLFillInBoundsArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFillInBoundsArrangement.h"

@implementation FLFillInBoundsArrangement

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {

	for(id object in objects) {
		if([object isHidden])  {
			continue;
		}
		
        bounds = [self setFrame:bounds forObject:object];
	}
    
    return bounds.size;
}

@end
