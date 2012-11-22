//
//  FLUserContext.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserContext.h"

@implementation FLUserContext

synthesize_(userLogin)


#if FL_MRC
- (void) dealloc {

    [_userLogin release];
    [super dealloc];
}
#endif


@end
