//
//  FLCoreTypes.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreTypes.h"
#import "FLType.h"



// core types

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

@implementation FLSimpleType

@end

@implementation FLNumberType 
- (id) init {
    return [self initWithClass:[NSNumber class] 
                       encoder:NSSelectorFromString(@"encodeStringWithNSNumber:") 
                       decoder:NSSelectorFromString(@"decodeNSNumberFromString:")];
}
- (FLTypeNumberType) numberType {
    return 0;
}
@end

@implementation FLBoolNumber 
- (id) init {
    return [self initWithClass:[NSNumber class] 
                       encoder:NSSelectorFromString(@"encodeStringWithBOOL:") 
                       decoder:NSSelectorFromString(@"decodeBOOLFromString:")];
}
+ (id) boolNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDBool;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"BOOL";
}
@end

@implementation FLCharNumber 
+ (id) charNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDChar;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"char";
}
@end

@implementation FLUnsignedCharNumber 
+ (id) unsignedCharNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedChar;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned char";
}

@end

@implementation FLShortNumber 
+ (id) shortNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDShort;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"short";
}

@end

@implementation FLUnsignedShortNumber 
+ (id) unsignedShortNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedShort;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned short";
}
@end

@implementation FLIntNumber 
+ (id) intNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDInt;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"int";
}
@end

@implementation FLUnsignedIntNumber 
+ (id) unsignedIntNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedInt;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned int";
}

@end

@implementation FLLongNumber 
+ (id) longNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"long";
}

@end

@implementation FLUnsignedLongNumber 
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
+ (id) unsignedLongNumber {
    return [self type];
}
- (NSString*) typeName {
    return @"unsigned long";
}

@end

@implementation FLLongLongNumber 
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLongLong;
}
+ (id) longLongNumber {
    return [self type];
}
- (NSString*) typeName {
    return @"long long";
}
@end

@implementation FLUnsignedLongLongNumber 
+ (id) unsignedLongLongNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLongLong;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned long long";
}
@end

@implementation FLFloatNumber 
+ (id) floatNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDFloat;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"float";
}

@end

@implementation FLDoubleNumber 
+ (id) doubleNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDDouble;
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"double";
}

@end

@implementation FLIntegerNumber 
+ (id) integerNumber {
    return [self type];
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
- (NSString*) typeName {
    return @"NSInteger";
}
@end

@implementation FLUnsignedIntegerNumber 
+ (id) unsignedIntegerNumber {
    return [self type];
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
- (NSString*) typeName {
    return @"NSUInteger";
}

@end

@implementation FLValueType 
@end

@implementation FLGeometrySize 
+ (id) geometrySize {
    return [self type];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (id) init {
    return [self initWithClass:[NSValue class]];
}

- (NSString*) typeName {
    return @"CGSize";
}


@end

@implementation FLGeometryRect 

+ (id) geometryRect {
    return [self type];
}

- (id) init {
    return [self initWithClass:[NSValue class]];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (NSString*) typeName {
    return @"CGRect";
}

@end

@implementation FLGeometryPoint 

+ (id) geometryPoint {
    return [self type];
}

- (id) init {
    return [self initWithClass:[NSValue class]];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (NSString*) typeName {
    return @"CGPoint";
}
@end

@implementation FLMutableArrayType
@end

@implementation NSString (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSString class] ]);
}
@end

@implementation NSMutableString (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSMutableString class] ]);
}
@end

@implementation NSArray (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSArray class] ]);
}
@end

@implementation NSMutableArray (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLMutableArrayType alloc] initWithClass:[NSMutableArray class] ]);
}
@end

@implementation NSURL (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSURL class] ]);
}
@end

@implementation NSData (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSData class] ]);
}
@end

@implementation NSMutableData (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSMutableData class] ]);
}
@end

@implementation NSDate (FLCoreTypes)
+ (FLType*) type {
    FLReturnStaticObject([[FLSimpleType alloc] initWithClass:[NSDate class] ]);
}
@end


