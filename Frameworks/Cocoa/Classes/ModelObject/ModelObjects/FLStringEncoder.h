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

@protocol FLStringEncoding <NSObject>
- (NSString*) stringFromObject:(id) object;
- (id) objectFromString:(NSString*) string;
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

@interface FLNumberStringEncoder : NSNumberFormatter<FLStringEncoding> 
+ (id) numberStringEncoder;
@end

@interface FLUTF8DataStringEncoder : NSObject<FLStringEncoding>
+ (id) utf8DataStringEncoder;
@end

@interface FLBoolStringEncoder : NSObject<FLStringEncoding>
+ (id) boolStringEncoder;
@end