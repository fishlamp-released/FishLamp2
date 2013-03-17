//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLType.h"

@interface FLType ()
//@property (readwrite, assign, nonatomic) FLTypeID typeID;
@property (readwrite, assign, nonatomic) SEL encodeSelector;
@property (readwrite, assign, nonatomic) SEL decodeSelector;
@property (readwrite, assign, nonatomic) Class classForType;
@property (readwrite, strong, nonatomic) NSString* typeName;

//// inflation helpers
//+ (id) registeredTypeForName:(NSString*) string;
//+ (void) registerType:(FLType*) desc;
//- (void) registerSelf;

@end



@implementation FLType
@synthesize classForType = _classForType;
@synthesize encodeSelector = _encodeSelector;
@synthesize decodeSelector = _decodeSelector;
@synthesize typeName = _typeName;

//static NSMutableDictionary* s_typeRegistry = nil;
//
//+ (void) initialize {
//    if(!s_typeRegistry) {
//        s_typeRegistry = [[NSMutableDictionary alloc] init];
//    }
//}
//
//+ (FLType*) registeredTypeForName:(NSString*) string {
//    @synchronized(s_typeRegistry) {
//        return [s_typeRegistry objectForKey:string];
//    }
//}
//
//+ (void) registerType:(FLType*) desc {
//    @synchronized(s_typeRegistry) {
//        [s_typeRegistry setObject:desc forKey:desc.typeName];
//    }
//}
//
//- (void) registerSelf {
//    [FLType registerType:self];
//}


- (id) initWithClass:(Class) aClass 
        withTypeName:(NSString*) typeName 
             encoder:(SEL) encoder 
             decoder:(SEL) decoder {
    self = [super init];
    if(self) {
        self.typeName = typeName;
        self.classForType = aClass;
        self.encodeSelector = encoder;
        self.decodeSelector = decoder;
    }
    return self;
}

- (id) initWithClass:(Class) aClass encoder:(SEL) encoder decoder:(SEL) decoder {
    return [self initWithClass:aClass withTypeName:NSStringFromClass(aClass) encoder:encoder decoder:decoder];
}

- (id) initWithClass:(Class) class withTypeName:(NSString*) typeName{

    SEL encoder = nil;
    SEL decoder = nil;
    
    if(class) {
        encoder = [FLType encodeSelectorForClass:class];
        decoder = [FLType decodeSelectorForClass:class];
    }
    
    return [self initWithClass:class withTypeName:typeName encoder: encoder decoder: decoder];
}    

- (id) initWithClass:(Class) aClass {
    return [self initWithClass:aClass withTypeName:NSStringFromClass(aClass)];
}


+ (id) typeWithClass:(Class) aClass   {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}


#if FL_MRC
- (void) dealloc {
    [_typeName release];
    [super dealloc];
}
#endif

+ (SEL) decodeSelectorForClass:(Class) aClass {
    return NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", NSStringFromClass(aClass)]);
}

+ (SEL) encodeSelectorForClass:(Class) aClass {
    return NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", NSStringFromClass(aClass)]);
}

- (FLType*) type {
    return self;
}

+ (FLType*) type {
    return nil;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { typeName=%@, classFoType=%@)", [super description], self.typeName, NSStringFromClass(_classForType)];
}

- (id) copyWithZone:(NSZone*) zone {
    return FLRetain(self);
}

- (BOOL) isEqual:(id) another {
    if(self == another) return YES;
    return [self isKindOfClass:[another class]] && (self.classForType == [another classForType]) && FLStringsAreEqual(self.typeName, [another typeName]);
}

- (NSUInteger) hash {
    return [self.typeName hash];
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
+ (FLType*) type {
    return [FLType typeWithClass:[self class]];
}
- (FLType*) type {
    return [FLType typeWithClass:[self class]];
}
@end



