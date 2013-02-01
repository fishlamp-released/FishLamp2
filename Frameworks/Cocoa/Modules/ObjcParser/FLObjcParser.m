//
//  FLObjcParser.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcParser.h"


@implementation FLObjcFileTokenizer 

//- (BOOL) isWhitespace:(unichar) aChar {
//    return [[NSCharacterSet letterCharacterSet] characterIsMember:aChar];
//}

- (BOOL) continueParsingToken:(NSRange) tokenRange 
                    withState:(FLStringTokenizerState*) state {
                    
    unichar aChar = state.currentChar;
                    
    if( [[NSCharacterSet alphanumericCharacterSet] characterIsMember:aChar] || 
        [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:aChar] ||
        aChar == '_') {
        
        return YES;
    }
    
    return NO;
}                    


@end

@implementation FLObjcParser

@end
