//
//  FLStringBuilderToken.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLCocoaRequired.h"
//
//#import "FLWhitespace.h"
//#import "FLPrettyString.h"
//
//@class FLStringBuilder;
//
//@protocol FLStringBuilderToken <NSObject /* NSCopying , NSCoding*/>
//- (void) buildStringWithPrettyString:(FLPrettyString*) stringAppender;
//
//@optional
//- (void) didMoveToParent:(id) parent;
//@end
//
//@interface NSString (FLStringBuilderToken)
//@end
//
//// numbers are used for serializing tabs.
//@interface NSNumber (FLStringBuilderToken)
//@end
//
//
////typedef NSString* (^FLTokenPlaceholderBlock)();
////
////@interface FLTokenPlaceholder : NSObject<FLStringBuilderToken> {
////@private
////    FLTokenPlaceholderBlock _block;
////}
////
////- (id) initWithBlock:(FLTokenPlaceholderBlock) block;
////+ (FLTokenPlaceholder*) tokenPlaceholder:(FLTokenPlaceholderBlock) block;
////
////@end
//
//
//
//// these are all singletons.
//
//@interface FLEolToken : NSObject<FLStringBuilderToken>
//+ (id) eolToken;
//@end
//
//@interface FLIndentToken : NSObject<FLStringBuilderToken> {
//}
//+ (id) indentToken;
//@end
//
//@interface FLOutdentToken : NSObject<FLStringBuilderToken> {
//}
//+ (id) outdentToken;
//@end
//
//
