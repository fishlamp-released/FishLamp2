//
//  FLBitsAreNotZero.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBitFlagsTest.h"

@implementation FLBitFlagTests

- (void) testBitFlags1 {

    FLBitFlags_t mask1 = 0;
    FLBitFlags_t mask2 = 0;

    for(int i = 0; i < 31; i++) {
        
        uint32_t flag = 1 << i;
        
        FLSetBits(mask1, flag);
        FLSetBitsAtomic(mask2, flag);
        FLAssert_v(mask1 == mask2, @"masks are not the same");
        
        FLAssertIsTrue_v(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsTrue_v(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsTrue_v(FLTestBits(mask1, flag), @"should be true");
        FLAssertIsTrue_v(FLTestBitsAtomic(mask2, flag), @"should be true");
        
    }
    
    for(int i = 0; i < 31; i++) {
        
        uint32_t flag = 1 << i;
    
        FLClearBits(mask1, flag);
        FLClearBitsAtomic(mask2, flag);
        
        FLAssert_v(mask1 == mask2, @"masks are not the same");

        FLAssertIsFalse_v(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsFalse_v(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsFalse_v(FLTestBits(mask1, flag), @"should be false");
        FLAssertIsFalse_v(FLTestBitsAtomic(mask2, flag), @"should should be false");

    }

    
    FLAssert_v(mask1 == 0, @"mask2 is not zero");
    FLAssert_v(mask2 == 0, @"mask2 is not zero");

}



- (void) testBitFlags2 {

    FLBitFlags_t mask1 = 0;
    FLBitFlags_t mask2 = 0;

    for(int i = 0; i < 32; i++) {
        
        uint32_t flag = 1 << i;
        
        FLSetOrClearBits(mask1, flag, YES);
        FLSetOrClearBitsAtomic(mask2, flag, YES);
        FLAssert_v(mask1 == mask2, @"masks are not the same");
        
        FLAssertIsTrue_v(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsTrue_v(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsTrue_v(FLTestAnyBit(mask1, flag), @"should be true");
        FLAssertIsTrue_v(FLTestAnyBitAtomic(mask2, flag), @"should be true");
        
    }
    
    for(int i = 0; i < 32; i++) {
        
        uint32_t flag = 1 << i;
    
        FLSetOrClearBits(mask1, flag, NO);
        FLSetOrClearBitsAtomic(mask2, flag, NO);

        FLAssert_v(mask1 == mask2, @"masks are not the same");

        FLAssertIsFalse_v(FLTestBits(mask1, flag), @"should be set");
        FLAssertIsFalse_v(FLTestBitsAtomic(mask2, flag), @"should be set");
        
        FLAssertIsFalse_v(FLTestAnyBit(mask1, flag), @"should be false");
        FLAssertIsFalse_v(FLGetBitsAtomic(mask2, flag), @"should should be false");

    }

    
    FLAssert_v(mask1 == 0, @"mask2 is not zero");
    FLAssert_v(mask2 == 0, @"mask2 is not zero");

}


@end
