//
//  FLCStyleCodeBuilder.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCStyleCodeBuilder.h"

@implementation FLCStyleCodeBuilder

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

+ (NSDictionary*) defaultScopeFormatters {

    FLReturnStaticObjectFromBlock((^{
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
        [dictionary addCodeScopeFormatter:[FLCStyleCodeFormatter instance]];
        return dictionary;
    }));
}

@end


@implementation FLCStyleCodeFormatter

FLSynthesizeSingleton(FLCStyleCodeFormatter);

- (FLCodeScopeId) scopeId {
    return FLCCodeScope;
}

- (void) openScope:(FLCodeBuilder*) codeBuilder
             scope:(FLCodeScope*) scope {
    
    [codeBuilder appendString:@"{"];
}             

- (void) closeScope:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope {
    [codeBuilder appendLine:@"}"];
}   

@end
