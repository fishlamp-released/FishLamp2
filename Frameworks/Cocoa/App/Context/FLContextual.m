//
//  FLContextual.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLContextual.h"

@interface FLContextual ()
@property (readwrite, assign) id context;
@end

@implementation FLContextual 

synthesize_(context);

- (void) removeFromContext:(id) context {
    self.context = nil;
}

- (void) addToContext:(id) context {
    self.context = context;
}

@end