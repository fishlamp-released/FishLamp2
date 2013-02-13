//
//  FLOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZenfolioWebApi.h"

@implementation FLOperation (ZenfolioHttp)

- (void) setUserContext:(FLZenfolioUserContext*) context {
    self.context = context;
}

- (FLZenfolioUserContext*) userContext {
    return (FLZenfolioUserContext*) self.context;
}

@end
