//
//  FLTypeDesc+BoxedStructs.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@implementation FLRectTypeDesc

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithRectValue:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeRectValueFromString:string];
}


@end
@implementation FLPointTypeDesc

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithPointValue:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodePointValueFromString:string];
}


@end
@implementation FLSizeTypeDesc

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithSizeValue:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeSizeValueFromString:string];
}

@end

@implementation FLTypeDesc (BoxedStructs)

+ (id) pointType {
    FLReturnStaticObject([[FLPointTypeDesc alloc] initWithName:@"CGPoint"]);
}
+ (id) rectType {
    FLReturnStaticObject([[FLRectTypeDesc alloc] initWithName:@"CGRect"]);
}
+ (id) sizeType {
    FLReturnStaticObject([[FLSizeTypeDesc alloc] initWithName:@"CGSize"]);
}
@end

@implementation FLBoxedStructTypeDesc

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return [NSValue class];
}

@end
