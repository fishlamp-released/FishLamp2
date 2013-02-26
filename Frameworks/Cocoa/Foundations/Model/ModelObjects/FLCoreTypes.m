//
//  FLCoreTypes.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreTypes.h"
#import "FLTypeDesc.h"



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

@implementation FLSimpleTypeDesc

@end

@implementation FLNumberTypeDesc 
- (id) init {
    return [self initWithClass:[NSNumber class] 
                       encoder:NSSelectorFromString(@"encodeStringWithNSNumber:") 
                       decoder:NSSelectorFromString(@"decodeNSNumberFromString:")];
}
- (FLTypeDescNumberType) numberType {
    return 0;
}
@end

@implementation FLBoolNumber 
+ (id) boolNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDBool;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"BOOL";
}
@end

@implementation FLCharNumber 
+ (id) charNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDChar;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"char";
}
@end

@implementation FLUnsignedCharNumber 
+ (id) unsignedCharNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedChar;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned char";
}

@end

@implementation FLShortNumber 
+ (id) shortNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDShort;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"short";
}

@end

@implementation FLUnsignedShortNumber 
+ (id) unsignedShortNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedShort;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned short";
}
@end

@implementation FLIntNumber 
+ (id) intNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDInt;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"int";
}
@end

@implementation FLUnsignedIntNumber 
+ (id) unsignedIntNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedInt;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned int";
}

@end

@implementation FLLongNumber 
+ (id) longNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDLong;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"long";
}

@end

@implementation FLUnsignedLongNumber 
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
+ (id) unsignedLongNumber {
    return [self typeDesc];
}
- (NSString*) typeName {
    return @"unsigned long";
}

@end

@implementation FLLongLongNumber 
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDLongLong;
}
+ (id) longLongNumber {
    return [self typeDesc];
}
- (NSString*) typeName {
    return @"long long";
}
@end

@implementation FLUnsignedLongLongNumber 
+ (id) unsignedLongLongNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedLongLong;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"unsigned long long";
}
@end

@implementation FLFloatNumber 
+ (id) floatNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDFloat;
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"float";
}

@end

@implementation FLDoubleNumber 
+ (id) doubleNumber {
    return [self typeDesc];
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDDouble;
}

+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (NSString*) typeName {
    return @"double";
}

@end

@implementation FLIntegerNumber 
+ (id) integerNumber {
    return [self typeDesc];
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDLong;
}
- (NSString*) typeName {
    return @"NSInteger";
}
@end

@implementation FLUnsignedIntegerNumber 
+ (id) unsignedIntegerNumber {
    return [self typeDesc];
}
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeDescNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
- (NSString*) typeName {
    return @"NSUInteger";
}

@end

@implementation FLValueTypeDesc 
@end

@implementation FLGeometrySize 
+ (id) geometrySize {
    return [self typeDesc];
}

+ (FLTypeDesc*) typeDesc {
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
    return [self typeDesc];
}

- (id) init {
    return [self initWithClass:[NSValue class]];
}

+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (NSString*) typeName {
    return @"CGRect";
}

@end

@implementation FLGeometryPoint 

+ (id) geometryPoint {
    return [self typeDesc];
}

- (id) init {
    return [self initWithClass:[NSValue class]];
}

+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (NSString*) typeName {
    return @"CGPoint";
}
@end

@implementation FLMutableArrayType
@end

@implementation NSString (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSString class] ]);
}
@end

@implementation NSMutableString (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSMutableString class] ]);
}
@end

@implementation NSArray (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSArray class] ]);
}
@end

@implementation NSMutableArray (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLMutableArrayType alloc] initWithClass:[NSMutableArray class] ]);
}
@end

@implementation NSURL (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSURL class] ]);
}
@end

@implementation NSData (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSData class] ]);
}
@end

@implementation NSMutableData (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSMutableData class] ]);
}
@end

@implementation NSDate (FLCoreTypes)
+ (FLTypeDesc*) typeDesc {
    FLReturnStaticObject([[FLSimpleTypeDesc alloc] initWithClass:[NSDate class] ]);
}
@end


