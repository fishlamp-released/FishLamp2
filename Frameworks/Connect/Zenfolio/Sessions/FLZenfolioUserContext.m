//
//  FLZenfolioUserContext.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioUserContext.h"

@implementation FLZenfolioUserContext
@synthesize rootGroup = _rootGroup;

#if FL_MRC
- (void) dealloc {
    [_rootGroup release];
    [super dealloc];
}
#endif

@end
