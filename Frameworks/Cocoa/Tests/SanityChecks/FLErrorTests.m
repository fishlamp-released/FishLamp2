//
//  FLErrorTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorTests.h"
#import "NSError+FLExtras.h"
#import "FLMutableError.h"


@implementation FLErrorTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) testMutableErrorCopy {
    
    NSError* error  = [NSError cancelError];
    FLAssertIsTrue(error.isCancelError);
    
    FLMutableError* mutableError = [FLMutableError mutableErrorWithError:error];
    
    FLAssertObjectsAreEqual(mutableError, error);
    
}

@end
