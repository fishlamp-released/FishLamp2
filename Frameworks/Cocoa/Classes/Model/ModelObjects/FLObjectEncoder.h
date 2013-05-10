//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLObjectEncoder.h"

#import <objc/runtime.h>

@protocol FLStringEncoder <NSObject>
- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;
@end

@interface FLObjectEncoder : NSObject<FLStringEncoder, NSCopying> {
@private
    SEL _encodeSelector;
    SEL _decodeSelector;
}
@property (readwrite, assign, nonatomic) SEL encodeSelector;
@property (readwrite, assign, nonatomic) SEL decodeSelector;

- (id) initWithEncodingKey:(NSString*) encodingKey;
+ (id) objectEncoderWithEncodingKey:(NSString*) encodingKey;

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;
@end

//@interface NSObject (FLObjectEncoder) 
////+ (id<FLStringEncoder>) objectEncoder;
////- (id<FLStringEncoder>) objectEncoder;
//@end
