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
        self.openBracket = @"{";
        self.closeBracket = @"}";
    }
    
    return self;
}

//- (id) initWithOpenBracketStyle:(FLOpenBracketStyle) openBracketStyle
//              closeBracketStyle:(FLCloseBracketStyle) closeBracketStyle {
//    
//    return = [super initWithOpenBracket:@"{" closeBracket:@"}" openBracketStyle:FLOpenBracketStyleDefault closeBracketStyle:FLCloseBracketStyleDefault];
//}
//
//+ (FLCStyleCodeBuilder*) cStyleCodeBuilder:(FLOpenBracketStyle) openBracketStyle
//                         closeBracketStyle:(FLCloseBracketStyle) closeBracketStyle {
// 
//    return [[[self class] alloc] initWithOpenBracketStyle:openBracketStyle closeBracketStyle:closeBracketStyle];
//}

@end

