//
//  FLStringBuilderScope.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLCocoaRequired.h"
//#import "FLStringBuilderToken.h"
//#import "FLStringFormatter.h"
//
//@class FLPrettyString;
//
//@interface FLStringBuilderScope : FLStringFormatter<FLStringBuilderToken> {
//@private
//    NSMutableArray* _tokens;
////    id _header;
////    id _footer;
//    __unsafe_unretained id _parent;
//}
//
//@property (readonly, assign, nonatomic) id document;
//@property (readonly, assign, nonatomic) id parent;
//
//// tokens
//@property (readonly, assign, nonatomic) NSUInteger tokenCount;
//@property (readonly, strong, nonatomic) FLEolToken* lastEolToken;
//@property (readonly, strong, nonatomic) id lastToken;
////@property (readwrite, strong, nonatomic) id header;
////@property (readwrite, strong, nonatomic) id footer;
//
//+ (FLStringBuilderScope*) stringBuilderScope;
//
//- (void) pushToken:(id) token;
//- (void) addToken:(id) token;
//- (void) insertToken:(id) token beforeToken:(id) token;
//- (void) insertToken:(id) token atIndex:(NSUInteger) atIndex;
//- (BOOL) isLastToken:(id) token;
//- (void) removeToken:(id) token;
//- (void) removeAllTokens;
//- (void) visitTokens:(void (^)(id token, BOOL* stop)) visitor; // visits in reverse order
//
//- (void) willBuildString:(FLPrettyString*) string;
//- (void) didBuildString:(FLPrettyString*) string;
//@end

//#import "FLPrettyString.h"
//
//@interface FLStringBuilderScope : NSObject {
//@private
//    NSMutableArray* _substrings;
//    
//    __unsafe_unretained id _parent;
//}
//@property (readwrite, assign, nonatomic) id parent;
//
//- (void) appendString:(FLPrettyString*) string;
//
//@end
//
