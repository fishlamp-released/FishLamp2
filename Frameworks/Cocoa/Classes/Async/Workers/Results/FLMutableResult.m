//
//  FLMutableResulting.m
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMutableResult.h"

@implementation FLMutableResult

@synthesize result = _result;

- (id) init {
    self = [super init];
    if(self) {
        self.result = FLSuccessfullResult;
    }
    return self;
}

- (id) initWithResult:(id) result {
    self = [super init];
    if(self) {
        self.result = result;
    }
    return self;
}

- (NSError*) error {
    return [self.result error];
}

+ (id) mutableResult {
    return autorelease_([[[self class] alloc] init]);
}

+ (id) mutableResultWithResult:(id) result {
    return autorelease_([[[self class] alloc] initWithResult:result]);
}

- (BOOL) succeeded {
    return [self.result succeeded];
}

- (BOOL) failed {
    return [self.result failed];
}

@end

