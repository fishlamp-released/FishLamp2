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

@interface FLObjectEncoder : NSObject<NSCopying> {
@private
    SEL _encodeSelector;
    SEL _decodeSelector;
}
@property (readwrite, assign, nonatomic) SEL encodeSelector;
@property (readwrite, assign, nonatomic) SEL decodeSelector;

- (id) initWithEncodingKey:(NSString*) encodingKey;
- (id) initWithClass:(Class) aClass;

+ (id) objectEncoder:(NSString*) encodingKey;
+ (id) objectEncoderForClass:(Class) aClass;

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;
@end

@interface NSObject (FLObjectEncoder) 
+ (FLObjectEncoder*) objectEncoder;
- (FLObjectEncoder*) objectEncoder;
+ (NSString*) encodingKey;
@end