//
//  FLBitsAreNotZero.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBitFlagsTest.h"

@implementation FLBitFlagTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) testBitFlags1 {

    FLBitFlags_t mask1 = 0;
    FLBitFlags_t mask2 = 0;

    for(int i = 0; i < 31; i++) {
        
        uint32_t flag = 1 << i;
        
        FLSetBits(mask1, flag);
        FLSetBitsAtomic(mask2, flag);
        FLAssertWithComment(mask1 == mask2, @"masks are not the same");
        
        FLAssertIsTrueWithComment(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsTrueWithComment(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsTrueWithComment(FLTestBits(mask1, flag), @"should be true");
        FLAssertIsTrueWithComment(FLTestBitsAtomic(mask2, flag), @"should be true");
        
    }
    
    for(int i = 0; i < 31; i++) {
        
        uint32_t flag = 1 << i;
    
        FLClearBits(mask1, flag);
        FLClearBitsAtomic(mask2, flag);
        
        FLAssertWithComment(mask1 == mask2, @"masks are not the same");

        FLAssertIsFalseWithComment(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsFalseWithComment(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsFalseWithComment(FLTestBits(mask1, flag), @"should be false");
        FLAssertIsFalseWithComment(FLTestBitsAtomic(mask2, flag), @"should should be false");

    }

    
    FLAssertWithComment(mask1 == 0, @"mask2 is not zero");
    FLAssertWithComment(mask2 == 0, @"mask2 is not zero");

}



- (void) testBitFlags2 {

    FLBitFlags_t mask1 = 0;
    FLBitFlags_t mask2 = 0;

    for(int i = 0; i < 32; i++) {
        
        uint32_t flag = 1 << i;
        
        FLSetOrClearBits(mask1, flag, YES);
        FLSetOrClearBitsAtomic(mask2, flag, YES);
        FLAssertWithComment(mask1 == mask2, @"masks are not the same");
        
        FLAssertIsTrueWithComment(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsTrueWithComment(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsTrueWithComment(FLTestAnyBit(mask1, flag), @"should be true");
        FLAssertIsTrueWithComment(FLTestAnyBitAtomic(mask2, flag), @"should be true");
        
    }
    
    for(int i = 0; i < 32; i++) {
        
        uint32_t flag = 1 << i;
    
        FLSetOrClearBits(mask1, flag, NO);
        FLSetOrClearBitsAtomic(mask2, flag, NO);

        FLAssertWithComment(mask1 == mask2, @"masks are not the same");

        FLAssertIsFalseWithComment(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsFalseWithComment(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsFalseWithComment(FLTestAnyBit(mask1, flag), @"should be false");
        FLAssertIsFalseWithComment(FLGetBitsAtomic(mask2, flag), @"should should be false");

    }

    
    FLAssertWithComment(mask1 == 0, @"mask2 is not zero");
    FLAssertWithComment(mask2 == 0, @"mask2 is not zero");

}


@end
