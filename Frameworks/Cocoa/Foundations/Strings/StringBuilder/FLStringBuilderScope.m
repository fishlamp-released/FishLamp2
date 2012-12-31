//
//  FLStringBuilderScope.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilderScope.h"
#import "FLWhitespace.h"

//@interface FLStringBuilderScope ()
//@end
//
//@implementation FLStringBuilderScope
//@synthesize parent = _parent;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//    }
//    return self;
//}
//
//+ (id) stringBuilderScope {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//- (void) willAppendToString:(FLPrettyString*) prettyString {
//    
//}    
//
//- (void) appendToString:(FLPrettyString*) prettyString {
//    [prettyString appendString:[self string]];
//}        
//
//    
//- (void) didAppendToString:(FLPrettyString*) prettyString {
//
//}    
//
//- (void) addSubstring:(FLStringBuilderScope*) string {
//    if(!_substrings) {
//        _substrings = [[NSMutableArray alloc] init];
//    }
//    
//    [_substrings addObject:string];
//    string.parent = self;
//}
//
//- (void) buildString:(NSMutableString*) string 
//      withWhitespace:(FLWhitespace*) whitespace {
//
////    [self willBuildStringWithWhitespace:whitespace];
//
//    [super buildString:string withWhitespace:whitespace];
//      
//}      
//
//
//#if FL_DEALLOC
//- (void) dealloc {
//    [_substrings release];
//    [super dealloc];
//}
//#endif
//@end
//
// 



//#import "FLStringBuilderScope.h"
//#import "FLStringBuilder.h"
//
//@implementation FLStringBuilder (FLStringBuilderScope)
//
//- (id) parent {
//    return nil;
//}
//
//- (id) document {
//    return self;
//}
//@end
//
//@interface FLStringBuilderScope ()
//
//@end
//
//@implementation FLStringBuilderScope
//
////@synthesize footer = _footer;
////@synthesize header = _header;
//@synthesize parent = _parent;
//
//- (id) document {
//    return [self.parent document];
//}
//
//- (void) didMoveToParent:(id) parent {
//
//    FLAssert_v(parent != self, @"parent can't be self");
//    _parent = parent;
//}
//
//+ (id) stringBuilderScope {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _tokens = [[NSMutableArray alloc] init];
//    }
//    return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_tokens release];
////    [_header release];
////    [_footer release];
//    [super dealloc];
//}
//#endif
//
//- (BOOL) isLastToken:(id) token {
//    return [_tokens lastObject] == token;
//}
//
//- (id) lastToken {
//    return [_tokens lastObject];
//}
//
//- (void) insertToken:(id) token beforeToken:(id) beforeToken {
//
//    NSMutableArray* tokens = _tokens;
//    for(NSInteger i = tokens.count - 1; i >= 0; i--) {
//        if(beforeToken == [tokens objectAtIndex:i]) {
//            [tokens insertObject:token atIndex: MAX(i - 1, 0)];
//            break;
//        }
//    }
//}
//
//- (void) insertToken:(id) token atIndex:(NSUInteger) atIndex {
//    [_tokens insertObject:token atIndex:atIndex];
//}
//
//- (void) pushToken:(id) token {
//    [_tokens insertObject:token atIndex:0];
//}
//
//- (NSUInteger) tokenCount {
//    return _tokens.count;
//}
//
//- (id) tokenAtIndex:(NSUInteger) index {
//    return [_tokens objectAtIndex:index];
//}
//
//- (void) replaceTokenAtIndex:(NSUInteger) index withToken:(id) token {
//    [_tokens replaceObjectAtIndex:index withObject:token];
//}
//
//- (void) addToken:(id) token {
//    [_tokens addObject:token];
//    FLPerformSelector1(token, @selector(didMoveToParent:), self);
//}
//
//- (void) visitTokens:(void (^)(id token, BOOL* stop)) visitor {
//    
//    BOOL stop = NO;
//    for(id token in _tokens.reverseObjectEnumerator) {
//    
//        visitor(token, &stop);
//        
//        if(stop) {
//            break;
//        }
//    }
//}
//
//- (FLEolToken*) lastEolToken {
//    for(id token in _tokens.reverseObjectEnumerator) {
//
//        if([token isKindOfClass:[FLEolToken class]]) {
//            return token;
//        }
//    }
//
//    return nil;
//}
//
//- (void) removeToken:(id) token {
//    [_tokens removeObject:token];
//    FLPerformSelector1(token, @selector(didMoveToParent:), nil);
//}
//
//- (void) removeAllTokens {
//    [_tokens removeAllObjects];
//}
//
//- (void) buildStringWithPrettyString:(FLPrettyString*) string {
//
//    [self willBuildString:string];
//
//    for(id object in _tokens) {
//        [object buildStringWithPrettyString:string];
//    }
//    
//    [self didBuildString:string];
//} 
//
//- (void) willAppendEOL {
//    [self addToken:[FLEolToken eolToken]];
//}
//
//- (void) willAppendTabs:(NSInteger) tabIndent {
//    if(tabIndent) {
//        [self addToken:[NSNumber numberWithInteger:tabIndent]];
//    }
//}
//
//- (void) willAppendString:(NSString*) string {
//    if(FLStringIsNotEmpty(string)) {
//        [self addToken:string];
//    }
//}          
//
//- (void) willBuildString:(FLPrettyString*) string {
//}
//
//- (void) didBuildString:(FLPrettyString*) string {
//}
//                              
//- (void) indent {
//    [super indent];
//    [self addToken:[FLIndentToken indentToken]];
//}
//
//- (void) outdent {
//    [super indent];
//    [self addToken:[FLOutdentToken outdentToken]];
//}
//
//@end


//- (id) initAsCopy:(FLStringBuilderScope*) original {
//    self = [self init];
//    if(self) {
//        _tokens = [original.tokens mutableCopy];
//        _header = [original.header copy];
//        _footer = [original.footer copy];
//    }
//    return self;
//}

//- (BOOL) isEmpty {
//    return !self. || _tokens.count == 0;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    if(_header) {
//        [aCoder encodeObject:_tokens forKey:@"_header"];
//    }
//    [aCoder encodeObject:_tokens forKey:@"_tokens"];
//    if(_footer) {
//        [aCoder encodeObject:_tokens forKey:@"_footer"];
//    }
////    [aCoder encodeInteger:_cursor forKey:@"_cursor"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if(self) {
//        _header = [aDecoder decodeObjectForKey:@"_header"];
//        _tokens = [aDecoder decodeObjectForKey:@"_tokens"];
//        _footer = [aDecoder decodeObjectForKey:@"_footer"];
////        _cursor = [aDecoder decodeIntegerForKey:@"_cursor"];
//    }
//    return self;
//}//- (id) copyWithZone:(NSZone *)zone {
//    return [[FLStringBuilderScope alloc] initAsCopy:self];
//}
