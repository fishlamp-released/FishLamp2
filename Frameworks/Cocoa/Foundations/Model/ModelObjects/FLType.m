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
@end

@implementation FLType

//@synthesize typeID = _typeID;
@synthesize classForType = _classForType;
@synthesize encodeSelector = _encodeSelector;
@synthesize decodeSelector = _decodeSelector;

static NSMutableDictionary* s_typeRegistry = nil;

+ (void) initialize {
    if(!s_typeRegistry) {
        s_typeRegistry = [[NSMutableDictionary alloc] init];
    }
}

+ (FLType*) registeredTypeForName:(NSString*) string {
    @synchronized(s_typeRegistry) {
        return [s_typeRegistry objectForKey:string];
    }
}

+ (void) registerType:(FLType*) desc {
    @synchronized(s_typeRegistry) {
        [s_typeRegistry setObject:desc forKey:desc.typeName];
    }
}

- (void) registerSelf {
    [FLType registerType:self];
}

- (FLType*) type {
    return self;
}

+ (FLType*) type {
    return nil;
}

- (id) initWithClass:(Class) aClass encoder:(SEL) encoder decoder:(SEL) decoder {
    self = [super init];
    if(self) {
        self.classForType = aClass;
        self.encodeSelector = encoder;
        self.decodeSelector = decoder;
    }
    return self;
}

+ (SEL) decodeSelectorForClass:(Class) aClass {
    return NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", NSStringFromClass(aClass)]);
}

+ (SEL) encodeSelectorForClass:(Class) aClass {
    return NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", NSStringFromClass(aClass)]);
}

- (id) initWithClass:(Class) class {

    SEL encoder = nil;
    SEL decoder = nil;
    
    if(class) {
        encoder = [FLType encodeSelectorForClass:class];
        decoder = [FLType decodeSelectorForClass:class];
    }
    
    return [self initWithClass:class encoder: encoder decoder: decoder];
}    

+ (id) typeWithClass:(Class) aClass   {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ (%@)", [super description], NSStringFromClass(_classForType)];
}

- (id) copyWithZone:(NSZone*) zone {
    return FLRetain(self);
}

- (BOOL) isEqual:(id) another {
    if(self == another) return YES;
    return (self.class == [another class]) && (self.classForType == [another classForType]);
}

- (NSUInteger) hash {
    return [NSStringFromClass([self class]) hash];
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

- (NSString*) typeName {
    return NSStringFromClass(_classForType);
}
@end

@implementation NSObject (FLType)
+ (FLType*) type {
    return [FLType typeWithClass:[self class]];
}
- (FLType*) type {
    return [FLType typeWithClass:[self class]];
}
@end



