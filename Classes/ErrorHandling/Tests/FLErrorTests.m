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

- (void) testMutableErrorCopy {
    
    NSError* error  = [NSError cancelError];
    FLAssertIsTrue_(error.isCancelError);
    
    FLMutableError* mutableError = [FLMutableError mutableErrorWithError:error];
    
    FLAssertObjectsAreEqual_(mutableError, error);
    
}

@end
