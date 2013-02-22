//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@interface FLTypeDesc ()
@property (readwrite, assign, nonatomic) FLTypeID typeID;
@property (readwrite, assign, nonatomic) SEL encodeSelector;
@property (readwrite, assign, nonatomic) SEL decodeSelector;
@property (readwrite, assign, nonatomic) Class typeClass;
@end

@interface FLNumberTypeDesc : FLTypeDesc
@end

@interface FLGeometryTypeDesc : FLTypeDesc 
@end

@implementation FLTypeDesc

@synthesize typeID = _typeID;
@synthesize typeClass = _typeClass;
@synthesize encodeSelector = _encodeSelector;
@synthesize decodeSelector = _decodeSelector;

static NSMutableDictionary* s_typeRegistry = nil;

+ (void) initialize {
    if(!s_typeRegistry) {
        s_typeRegistry = [[NSMutableDictionary alloc] init];
    }
}

+ (FLTypeDesc*) registeredTypeForName:(NSString*) string {
    @synchronized(s_typeRegistry) {
        return [s_typeRegistry objectForKey:string];
    }
}

+ (void) registerTypeDesc:(FLTypeDesc*) desc {
    @synchronized(s_typeRegistry) {
        [s_typeRegistry setObject:desc forKey:desc.typeName];
    }
}

- (void) registerSelf {
    [FLTypeDesc registerTypeDesc:self];
}


- (id) initWithClass:(Class) aClass typeID:(FLTypeID) typeID encoder:(SEL) encoder decoder:(SEL) decoder {
    self = [super init];
    if(self) {
        self.typeID = typeID;
        self.typeClass = aClass;
        self.encodeSelector = encoder;
        self.decodeSelector = decoder;
    }
    return self;
}

- (id) initWithClass:(Class) class typeID:(FLTypeID) typeID {

    SEL encoder = nil;
    SEL decoder = nil;
    
    if(class) {
        NSString* name = NSStringFromClass(class);
        encoder = NSSelectorFromString([NSString stringWithFormat:@"typeDesc:encodeStringWith%@:", name]);
        decoder = NSSelectorFromString([NSString stringWithFormat:@"typeDesc:decode%@FromString:", name]);
    }
    
    return [self initWithClass:class typeID:typeID encoder: encoder decoder: decoder];
}    

+ (id) typeDescWithClass:(Class) aClass typeID:(FLTypeID) typeID  {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass typeID:typeID]);
}

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder performSelector:self.encodeSelector withObject:self withObject:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder performSelector:self.decodeSelector withObject:self withObject:string];
}

- (NSString*) typeName {
    return NSStringFromClass(_typeClass);
}

+ (id) boolType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDBool]);
}

+ (id) charType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDChar]);
}

+ (id) unsignedCharType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDUnsignedChar]);
}

+ (id) shortType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDShort]);
}

+ (id) unsignedShortType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDUnsignedShort]);
}

+ (id) intType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDInt]);
}

+ (id) unsignedIntType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDUnsignedInt]);
}

+ (id) longType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDLong]);
}

+ (id) unsignedLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDUnsignedLong]);
}

+ (id) longLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDLongLong]);
}

+ (id) unsignedLongLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDUnsignedLongLong]);
}

+ (id) floatType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDFloat]);
}

+ (id) doubleType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDDouble]);
}

//+ (id) enumType {
//    FLReturnStaticObject([[FLEnumTypeDesc alloc] initWithClass:[NSNumber class] typeID:FLTypeIDEnum]);
//}

+ (id) stringType {
    FLReturnStaticObject([[[self class] alloc] initWithClass:[NSString class] typeID:FLTypeIDString]);
}

+ (id) dateType {
    FLReturnStaticObject([[[self class] alloc] initWithClass:[NSDate class] typeID:FLTypeIDDate]);
}

+ (id) dataType {
    FLReturnStaticObject([[[self class] alloc] initWithClass:[NSData class] typeID:FLTypeIDData]);
}

+ (id) URLType {
    FLReturnStaticObject([[[self class] alloc] initWithClass:[NSURL class] typeID:FLTypeIDURL]);
}

+ (id) pointType {
    FLReturnStaticObject([[FLGeometryTypeDesc alloc] initWithClass:[NSValue class] typeID:FLTypeIDPoint]);
}

+ (id) rectType {
    FLReturnStaticObject([[FLGeometryTypeDesc alloc] initWithClass:[NSValue class] typeID:FLTypeIDRect]);
}

+ (id) sizeType {
    FLReturnStaticObject([[FLGeometryTypeDesc alloc] initWithClass:[NSValue class] typeID:FLTypeIDSize]);
}

+ (id) abstractObjectTypeDesc {
    FLReturnStaticObject([[[self class] alloc] initWithClass:nil typeID:FLTypeIDAbstractObject]);
}

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isGeometry {
    return NO;
}

- (BOOL) isObject {
    return YES;
}

@end

@implementation FLNumberTypeDesc

- (NSString*) typeName {
    switch(self.typeID) {
        case FLTypeIDBool: return @"bool";
        case FLTypeIDChar: return @"char";
        case FLTypeIDUnsignedChar: return @"unsignedChar";
        case FLTypeIDShort: return @"short";
        case FLTypeIDUnsignedShort: return @"unsignedShort";
        case FLTypeIDInt: return @"int";
        case FLTypeIDUnsignedInt: return @"unsignedInt";
        case FLTypeIDLong: return @"long";
        case FLTypeIDUnsignedLong: return @"unsignedLong";
        case FLTypeIDLongLong: return @"longLong";
        case FLTypeIDUnsignedLongLong: return @"unsignedLongLong";
        case FLTypeIDFloat: return @"float";
        case FLTypeIDDouble: return @"double";
    }
    return nil;
}

- (BOOL) isNumber {
    return YES;
}

- (BOOL) isGeometry {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

@end

@implementation FLGeometryTypeDesc

- (NSString*) typeName {
    switch(self.typeID) {
        case FLTypeIDRect: return @"rect"; break;
        case FLTypeIDPoint: return @"point"; break;
        case FLTypeIDSize: return @"size"; break;
    }
    return nil;
}

//- (id) initWithGeometryType:(FLTypeID) geometryType {
//    NSString* name = [FLGeometryTypeDesc stringFromGeometryType:geometryType];
//    SEL encoder = [FLTypeDesc encodeSelectorForType:name];
//    SEL decoder = [FLTypeDesc decodeSelectorForType:name];
//    return [self initWithClass:[NSValue class] typeID:geometryType encoder: encoder decoder: decoder];
//}


- (BOOL) isNumber {
    return NO;
}

- (BOOL) isGeometry {
    return YES;
}

- (BOOL) isObject {
    return NO;
}


@end
