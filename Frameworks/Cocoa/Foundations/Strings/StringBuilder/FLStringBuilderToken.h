//
//  FLStringBuilderToken.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLWhitespace.h"
@class FLStringBuilder;

@protocol FLStringBuilderToken <NSObject, NSCopying, NSCoding>

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent;
@end

@interface NSString (FLStringBuilderToken)
@end

@interface FLTokenPlaceholder : NSObject<FLStringBuilderToken, NSCopying, NSCoding> {
@private
    id _token;
}

- (id) initWithToken:(id) token;

+ (FLTokenPlaceholder*) tokenPlaceholder;
+ (FLTokenPlaceholder*) tokenPlaceholder:(id) tokenOrNil;

@property (readwrite, strong, nonatomic) id token;

@end

@interface FLEolToken : FLTokenPlaceholder
+ (id) eolToken;
@end

@interface FLIndentToken : FLTokenPlaceholder {
}
+ (FLIndentToken*) indentToken;
@end

@interface FLOutdentToken : FLTokenPlaceholder {
}
+ (FLOutdentToken*) outdentToken;
@end

@interface FLSingleLineToken : FLEolToken {
@private
    NSString* _line;
}

@property (readwrite, strong, nonatomic) NSString* line;

+ (FLSingleLineToken*) singleLineToken:(NSString*) line;


@end