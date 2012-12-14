//
//  FLHttpServerService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpServerService.h"

@implementation FLHttpServerService

@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;

#if FL_MRC
- (void) dealloc {

    [_httpRequestAuthenticator release];
    [super dealloc];
}
#endif

@end
