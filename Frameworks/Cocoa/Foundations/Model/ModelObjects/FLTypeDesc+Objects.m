//
//  FLTypeDesc+Objects.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@interface FLSpecificObjectTypeDesc ()
@property (readwrite, assign, nonatomic) Class classForType;
- (id) initWithClass:(Class) aClass;
@end

@implementation FLTypeDesc (Objects)
+ (id) stringType {
    FLReturnStaticObject([[FLStringTypeDesc alloc] init]);
}
+ (id) dateType {
    FLReturnStaticObject([[FLDateTypeDesc alloc] init]);
}
+ (id) URLType {
    FLReturnStaticObject([[FLURLTypeDesc alloc] init]);
}

+ (id) objectType {
    FLReturnStaticObject([[FLGenericObjectTypeDesc alloc] init]);
}
+ (id) objectTypeWithClass:(Class) typeClass {
    return FLAutorelease([[FLSpecificObjectTypeDesc alloc] initWithClass:typeClass]);
}

+ (id) dataType {
    FLReturnStaticObject([[FLDataTypeDesc alloc] init]);
}

@end

@implementation FLSpecificObjectTypeDesc

@synthesize classForType = _typeClass;

- (id) initWithClass:(Class) class {
    return [self initWithName:NSStringFromClass(class)];
}    

- (void) registerSelf {
}         

@end

@implementation FLStringTypeDesc

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return [NSString class];
}

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithString:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeStringFromString:string];
}

@end

@implementation FLDateTypeDesc

- (id) init {
    self = [super initWithName:@"NSDate"];
    if(self) {
        
    }
    return self;
}

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return [NSDate class];
}

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithDate:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeDateFromString:string];
}

@end

@implementation FLURLTypeDesc

- (id) init {
    self = [super initWithName:@"NSURL"];
    if(self) {
        
    }
    return self;
}

- (BOOL) isNumber {
    return NO;
}

- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return [NSDate class];
}

- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithURL:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeURLFromString:string];
}


@end



@implementation FLGenericObjectTypeDesc 

- (id) init {
    return [self initWithName:@"id"];
}

- (BOOL) isNumber {
    return NO;
}
- (BOOL) isObject {
    return YES;
}

@end