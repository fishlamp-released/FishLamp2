//
//  FLCoreTypes.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreTypes.h"
#import "FLType.h"

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

- (id) initNumberWithTypeName:(NSString*) typeName {
    return [self initWithClass:[NSNumber class] 
                      withTypeName:(NSString*) typeName
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
                      withTypeName:@"BOOL"
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

@end

@implementation FLCharNumber 

- (id) init {
    return [super initNumberWithTypeName:@"char"];
}

+ (id) charNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDChar;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedCharNumber 

- (id) init {
    return [super initNumberWithTypeName:@"unsigned char"];
}

+ (id) unsignedCharNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedChar;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLShortNumber 
- (id) init {
    return [super initNumberWithTypeName:@"short"];
}
+ (id) shortNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDShort;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
@end

@implementation FLUnsignedShortNumber 
- (id) init {
    return [super initNumberWithTypeName:@"unsigned short"];
}
+ (id) unsignedShortNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedShort;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLIntNumber 
- (id) init {
    return [super initNumberWithTypeName:@"int"];
}+ (id) intNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDInt;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedIntNumber 
- (id) init {
    return [super initNumberWithTypeName:@"unsigned int"];
}

+ (id) unsignedIntNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedInt;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}


@end

@implementation FLLongNumber 
- (id) init {
    return [super initNumberWithTypeName:@"long"];
}
+ (id) longNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLUnsignedLongNumber 
- (id) init {
    return [super initNumberWithTypeName:@"unsigned long"];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLong;
}
+ (id) unsignedLongNumber {
    return [self type];
}

@end

@implementation FLLongLongNumber 
- (id) init {
    return [super initNumberWithTypeName:@"long long"];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLongLong;
}
+ (id) longLongNumber {
    return [self type];
}

@end

@implementation FLUnsignedLongLongNumber 
- (id) init {
    return [super initNumberWithTypeName:@"unsigned long long"];
}
+ (id) unsignedLongLongNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDUnsignedLongLong;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLFloatNumber 
- (id) init {
    return [super initNumberWithTypeName:@"float"];
}
+ (id) floatNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDFloat;
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}


@end

@implementation FLDoubleNumber 
- (id) init {
    return [super initNumberWithTypeName:@"double"];
}
+ (id) doubleNumber {
    return [self type];
}
- (FLTypeNumberType) numberType {
    return FLTypeIDDouble;
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
@end

@implementation FLIntegerNumber 
- (id) init {
    return [super initNumberWithTypeName:@"NSInteger"];
}
+ (id) integerNumber {
    return [self type];
}
+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}
- (FLTypeNumberType) numberType {
    return FLTypeIDLong;
}
@end

@implementation FLUnsignedIntegerNumber 
- (id) init {
    return [super initNumberWithTypeName:@"NSUInteger"];
}
+ (id) unsignedIntegerNumber {
    return [self type];
}
+ (FLType*) type {
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
    return [self type];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

- (id) init {
    return [self initWithClass:[NSValue class] withTypeName:@"CGSize"];
}

@end

@implementation FLGeometryRect 

+ (id) geometryRect {
    return [self type];
}

- (id) init {
    return [self initWithClass:[NSValue class] withTypeName:@"CGRect"];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end

@implementation FLGeometryPoint 

+ (id) geometryPoint {
    return [self type];
}

- (id) init {
    return [self initWithClass:[NSValue class] withTypeName:@"CGPoint"];
}

+ (FLType*) type {
    FLReturnStaticObject([[[self class] alloc] init]);
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


