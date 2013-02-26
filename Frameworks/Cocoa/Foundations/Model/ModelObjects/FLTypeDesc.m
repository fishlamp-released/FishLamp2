//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@interface FLTypeDesc ()
//@property (readwrite, assign, nonatomic) FLTypeID typeID;
@property (readwrite, assign, nonatomic) SEL encodeSelector;
@property (readwrite, assign, nonatomic) SEL decodeSelector;
@property (readwrite, assign, nonatomic) Class typeClass;
@end

@implementation FLTypeDesc

//@synthesize typeID = _typeID;
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


- (id) initWithClass:(Class) aClass encoder:(SEL) encoder decoder:(SEL) decoder {
    self = [super init];
    if(self) {
        self.typeClass = aClass;
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
        encoder = [FLTypeDesc encodeSelectorForClass:class];
        decoder = [FLTypeDesc decodeSelectorForClass:class];
    }
    
    return [self initWithClass:class encoder: encoder decoder: decoder];
}    

+ (id) typeDescWithClass:(Class) aClass   {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder performSelector:self.encodeSelector withObject:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder performSelector:self.decodeSelector withObject:string];
}

- (NSString*) typeName {
    return NSStringFromClass(_typeClass);
}
@end

@implementation NSObject (FLTypeDesc)
+ (FLTypeDesc*) typeDesc {
    return [FLTypeDesc typeDescWithClass:[self class]];
}
@end



