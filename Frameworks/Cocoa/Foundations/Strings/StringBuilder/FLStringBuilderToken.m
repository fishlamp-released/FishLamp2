////
////  FLStringBuilderToken.m
////  FishLamp
////
////  Created by Mike Fullerton on 9/18/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLStringBuilderToken.h"
//#import "FLStringBuilder.h"
//
//@implementation NSString (FLStringBuilder)
//
//- (void) buildStringWithPrettyString:(FLPrettyString*) string {
//    
//    if(self.length) {
//        [string appendString:self];
//    }
//}
//
//@end
//
////@implementation NSNumber (FLStringBuilder)
////
////- (void) buildStringWithPrettyString:(FLPrettyString*) string {
////    
////    NSInteger tabIndent = [self integerValue];
////    if(tabIndent) {
////        [string willAppendTabs:tabIndent];
////    }
////}
////
////@end
//
//
////@implementation FLTokenPlaceholder
////
////- (id) initWithBlock:(FLTokenPlaceholderBlock) block {
////    self = [super init];
////    if(self) {
////        _block = [_block copy];
////    }
////    return self;
////}
////
////+ (FLTokenPlaceholder*) tokenPlaceholder:(FLTokenPlaceholderBlock) block {
////    return FLAutorelease([[[self class] alloc] initWithBlock:block]);
////}
////
////- (void) buildStringWithPrettyString:(FLPrettyString*) string {
////    
////    if(_block) {
////        NSString* newString = _block();
////        if(newString) {
////            [string appendString:newString];
////        }
////    }
////}
////
////#if FL_MRC
////- (void) dealloc {
////    [_block release];
////    [super dealloc];
////}
////#endif
////
////
////@end
//
//@implementation FLEolToken
//
//+ (id) eolToken {
//    FLReturnStaticObject([[[self class] alloc] init]);
//}
//
//- (void) buildStringWithPrettyString:(FLPrettyString*) string {
//    [string appendLine];
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//    return FLRetain(self);
//}
//
//@end
//
////@implementation FLTabsToken
////
////+ (id) tabsToken {
////    FLReturnStaticObject([[[self class] alloc] init]);
////}
////
////- (void) buildStringWithPrettyString:(FLPrettyString*) string {
////    [string indent];
////}
////
////- (id)copyWithZone:(NSZone *)zone {
////    return FLRetain(self);
////}
////@end
//
//@implementation FLIndentToken
//
//+ (id) indentToken {
//    FLReturnStaticObject([[[self class] alloc] init]);
//}
//
//- (void) buildStringWithPrettyString:(FLPrettyString*) string {
//    [string indent];
//}
//- (id)copyWithZone:(NSZone *)zone {
//    return FLRetain(self);
//}
//@end
//
//@implementation FLOutdentToken
//
//+ (id) outdentToken {
//    FLReturnStaticObject([[[self class] alloc] init]);
//}
//
//- (void) buildStringWithPrettyString:(FLPrettyString*) string {
//    [string outdent];
//}
//- (id)copyWithZone:(NSZone *)zone {
//    return FLRetain(self);
//}
//@end
//
////@implementation FLSingleLineToken
////
////@synthesize line = _line;
////
////+ (FLSingleLineToken*) singleLineToken:(NSString*) line {
////    FLSingleLineToken* token = FLAutorelease([[[self class] alloc] init]);
////    token.line = line;
////    return token;
////}
////
////- (void) buildStringWithPrettyString:(NSMutableString*) string
////              inScope:(id) scope
////          withWhitespace:(FLWhitespace*) whitespace
////               tabIndent:(NSInteger) tabIndent {
////
////    [_line buildStringWithPrettyString:string withWhitespace:whitespace tabIndent:tabIndent];
////    [super buildStringWithPrettyString:string withWhitespace:whitespace tabIndent:tabIndent];
////}
////
////@end
