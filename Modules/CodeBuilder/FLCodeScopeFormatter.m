//
//  FLCodeScopeFormatter.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCodeScopeFormatter.h"

@implementation FLCodeScopeFormatter

- (FLCodeScopeId) scopeId {
    return [[self class] scopeId];
}

+ (FLCodeScopeFormatter*) scopeFormatter {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) openScope:(FLCodeBuilder*) codeBuilder
             scope:(FLCodeScope*) scope {
}             

- (void) closeScope:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope {
} 

- (void) appendLine:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope 
               line:(NSString*) line {
               
}

- (void) appendScopedLine:(FLCodeBuilder*) codeBuilder
                  scope:(FLCodeScope*) scope 
                   line:(NSString*) line {
                   
}

+ (FLCodeScopeId) scopeId {
    return 0;
}      

@end

