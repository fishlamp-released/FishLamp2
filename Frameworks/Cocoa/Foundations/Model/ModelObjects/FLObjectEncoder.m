//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectEncoder.h"

@interface FLObjectEncoder ()
@end

@implementation FLObjectEncoder

@synthesize encodeSelector = _encodeSelector;
@synthesize decodeSelector = _decodeSelector;

- (id) initWithEncodingKey:(NSString*) encodingKey {

    FLAssert_([encodingKey rangeOfString:@"_"].length == 0)

    self = [super init];
    if(self) {
        self.encodeSelector = NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", encodingKey]);
        self.decodeSelector = NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", encodingKey]);
    }

    return self;
}    

- (id) initWithClass:(Class) aClass {
    return [self initWithEncodingKey:[aClass encodingKey]];
}

+ (id) objectEncoder:(NSString*) encodingKey {
	return FLAutorelease([[[self class] alloc] initWithEncodingKey:encodingKey]);
}

+ (id) objectEncoderForClass:(Class) aClass   {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}

//+ (SEL) decodeSelectorForClass:(Class) aClass {
//    return NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", NSStringFromClass(aClass)]);
//}
//
//+ (SEL) encodeSelectorForClass:(Class) aClass {
//    return NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", NSStringFromClass(aClass)]);
//}

//- (NSString*) description {
//    return [NSString stringWithFormat:@"%@ { typeName=%@, classFoType=%@)", [super description], self.typeName, NSStringFromClass(_classForType)];
//}

- (id) copyWithZone:(NSZone*) zone {
    return FLRetain(self);
}

//- (BOOL) isEqual:(id) another {
//    if(self == another) return YES;
//    return [self isKindOfClass:[another class]] && (self.actualClass == [another actualClass]) && FLStringsAreEqual(self.typeName, [another typeName]);
//}

//- (NSUInteger) hash {
//    return [self.typeName hash];
//}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder performSelector:self.encodeSelector withObject:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder performSelector:self.decodeSelector withObject:string];
}

#pragma GCC diagnostic pop
@end


@implementation NSObject (FLType)
+ (FLObjectEncoder*) objectEncoder {
    return [FLObjectEncoder objectEncoderForClass:[self class]];
}

- (FLObjectEncoder*) objectEncoder {
    return [[self class] objectEncoder];
}

+ (NSString*) encodingKey {
    return NSStringFromClass([self class]); 
}
@end
