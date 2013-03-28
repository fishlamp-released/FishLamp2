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

    FLAssert([encodingKey rangeOfString:@"_"].length == 0);

    self = [super init];
    if(self) {
        self.encodeSelector = NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", encodingKey]);
        self.decodeSelector = NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", encodingKey]);
    }

    return self;
}    

+ (id) objectEncoderWithEncodingKey:(NSString*) encodingKey {
	return FLAutorelease([[[self class] alloc] initWithEncodingKey:encodingKey]);
}

- (id) copyWithZone:(NSZone*) zone {
    return FLRetain(self);
}

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
    return nil; // [FLObjectEncoder objectEncoderForClass:[self class]];
}

- (FLObjectEncoder*) objectEncoder {
    return [[self class] objectEncoder];
}

@end
