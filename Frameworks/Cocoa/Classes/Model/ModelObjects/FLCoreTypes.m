//
//  FLCoreTypes.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreTypes.h"
#import "FLObjectEncoder.h"

// objects
enum  {
    FLTypeIDObject              = _C_CLASS,
    FLTypeIDAbstractObject      = _C_ID,
    FLTypeIDString              = 'stro',
    FLTypeIDDate                = 'date',
    FLTypeIDURL                 = 'urlo',
    FLTypeIDData                = 'data'
};     

// geometry 
enum {
	FLTypeIDPoint               = 'poin',
	FLTypeIDRect                = 'rect',
	FLTypeIDSize                = 'size',
};


@implementation FLNumberEncoder 

- (id) init {
    return [self initWithEncodingKey:@"Number"];
}

- (FLTypeNumberType) numberType {
    return 0;
}
@end

@implementation FLBoolNumber 
- (id) init {
    return [self initWithEncodingKey:@"BOOL"];
}

+ (id) boolNumber {
    return [self objectEncoder];
}

- (FLTypeNumberType) numberType {
    return FLTypeIDBool;
}

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLCharNumber 

+ (id) charNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDChar;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedCharNumber 


+ (id) unsignedCharNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedChar;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLShortNumber 

+ (id) shortNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDShort;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
@end

@implementation FLUnsignedShortNumber 

+ (id) unsignedShortNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedShort;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLIntNumber 

+ (id) intNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDInt;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedIntNumber 

+ (id) unsignedIntNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedInt;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}


@end

@implementation FLLongNumber 

+ (id) longNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedLongNumber 


+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
+ (id) unsignedLongNumber {
    return [self objectEncoder];
}

@end

@implementation FLLongLongNumber 

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLongLong;
}
+ (id) longLongNumber {
    return [self objectEncoder];
}

@end

@implementation FLUnsignedLongLongNumber 

+ (id) unsignedLongLongNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLongLong;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLFloatNumber 

+ (id) floatNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDFloat;
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}


@end

@implementation FLDoubleNumber 

+ (id) doubleNumber {
    return [self objectEncoder];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDDouble;
}

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
@end

@implementation FLIntegerNumber 

+ (id) integerNumber {
    return [self objectEncoder];
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
@end

@implementation FLUnsignedIntegerNumber 

+ (id) unsignedIntegerNumber {
    return [self objectEncoder];
}
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLong;
}

@end

@implementation FLValueType 
@end

@implementation FLGeometrySize 
+ (id) geometrySize {
    return [self objectEncoder];
}

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (id) init {
    return [self initWithEncodingKey:@"Size"];
}

@end

@implementation FLGeometryRect 

+ (id) geometryRect {
    return [self objectEncoder];
}

- (id) init {
    return [self initWithEncodingKey:@"Rect"];
}

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLGeometryPoint 

+ (id) geometryPoint {
    return [self objectEncoder];
}

- (id) init {
    return [self initWithEncodingKey:@"Point"];
}

+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLMutableArrayType
@end

@implementation NSString (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"String"]);
}

@end

//@implementation NSMutableString (FLCoreTypes)
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:[NSMutableString class] ]);
//}
//@end

@implementation NSArray (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Array"]);
}
@end

@implementation NSMutableArray (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLMutableArrayType alloc] initWithEncodingKey:@"MutableArray"]);
}
@end

@implementation NSURL (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"URL" ]);
}
@end

@implementation NSData (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Data" ]);
}
@end

//@implementation NSMutableData (FLCoreTypes)
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:[NSMutableData class] ]);
//}
//@end

@implementation NSDate (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Date" ]);
}
@end

@implementation SDKFont (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Font"]);
}
@end


