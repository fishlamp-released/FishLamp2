//
//  FLBracketedStringBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBracketedStringBuilder.h"

//@implementation FLBracketedStringBuilder
//
//@synthesize openBracketStyle = _openStyle;
//@synthesize closeBracketStyle = _closeStyle;
//@synthesize openBracket =  _openBracket;
//@synthesize closeBracket = _closeBracket;
//
//- (id) initWithOpenBracket:(NSString*) openBracket
//              closeBracket:(NSString*) closeBracket
//          openBracketStyle:(FLOpenBracketStyle) openBracketStyle
//         closeBracketStyle:(FLCloseBracketStyle) closeBracketStyle {
// 
//    self = [super init];
//    if(self) {
//        _openBracket = openBracket;
//        _closeBracket = closeBracket;
//        _openStyle = openBracketStyle;
//        _closeStyle = closeBracketStyle;
//    }
//    
//    return self;
//    
//}
//
//+ (FLCStyleCodeBuilder*) cStyleCodeBuilder:(NSString*) openBracket
//                              closeBracket:(NSString*) closeBracket
//                          openBracketStyle:(FLOpenBracketStyle) openBracketStyle
//                         closeBracketStyle:(FLCloseBracketStyle) closeBracketStyle {
//    
//     return [[[self class] alloc] initWithOpenBracket:openBracket closeBracket:closeBracker openBracketStyle:openBracketStyle closeBracketStyle:closeBracketStyle];
//}
//
//- (void) willOpenInBuilder:(FLStringBuilder*) builder {
//    
//    switch(_openStyle) {
//        switch FLOpenBracketStyleDefault: {
//            FLEolToken* eol = builder.lastEolToken;
//            if(eol) {
//                eol.token = @" {";
//            }
//            else {
//                [builder appendLine:@"{"];
//            }
//        }
//            
//        break;
//            
//        switch FLOpenBracketStyleNewLine:
//            [builder appendLine:@"{"];
//        break;
//        
//        switch FLOpenBracketStyleNewLineTabbed:
//            [self appendLine:@"{"];
//        break;
//
//    }
//    
//}
//
//- (void) didCloseInBuilder:(FLStringBuilder*) builder {
//
//    switch(_closeStyle) {
//        case FLCloseBracketStyleDefault:
//            [builder appendLine:@"}"];
//        break;
//        
//        case FLCloseBracketStyleTabbed:
//            [self appendLine:@"}"];
//        break;
//    }
//
//}
//
//@end
