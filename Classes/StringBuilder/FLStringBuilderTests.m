//
//  FLStringBuilderTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLStringBuilderTests.h"
#import "FLUnitTest.h"

@implementation FLStringBuilder (UnitTests)

- (void) _unitTestBasicStuff:(FLUnitTest*) unitTest {
    
    FLStringBuilder* builder = [FLStringBuilder stringBuilder];
    
    [builder appendLine:@"Hello"];
    [builder indent];
    [builder appendLine:@"World"];
    [builder indent];
    [builder appendLine:@"Testing 123"];
    [builder undent];
    [builder appendLine:@"Farkle"];
    
    FLLog([builder description]);
    
}

@end
