//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "ISO8601DateFormatter.h"

@class FLBase64Data;

@protocol FLStringEncoding <NSObject>
- (NSString*) stringFromObject:(id) object;
- (id) objectFromString:(NSString*) string;
- (NSArray*) encodingKeys;
@end

@interface NSObject (FLEncodingSelectors)
+ (NSString*) stringEncodingKey;
@end

@interface FLStringEncoder : NSObject<FLStringEncoding>
+ (id) stringEncoder;
@end

@interface FLISO8601DateStringEncoder : ISO8601DateFormatter<FLStringEncoding>
+ (id) dateStringEncoder;
@end

@interface FLURLStringEncoder : NSObject<FLStringEncoding>
+ (id) urlStringEncoder;
@end

@interface FLNumberStringEncoder : NSObject<FLStringEncoding> 
+ (id) numberStringEncoder;
@end

@interface FLUTF8DataStringEncoder : NSObject<FLStringEncoding>
+ (id) utf8DataStringEncoder;
@end

@interface FLBoolStringEncoder : NSObject<FLStringEncoding>
+ (id) boolStringEncoder;
@end

@interface FLBase64DataStringEncoder : NSObject<FLStringEncoding> {
@private
    id<FLStringEncoding> _stringEncoder;
}
+ (id) base64DataStringEncoder:(id<FLStringEncoding>) stringEncoder;
@end