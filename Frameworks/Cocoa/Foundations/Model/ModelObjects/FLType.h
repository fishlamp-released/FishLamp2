//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLType.h"

#import <objc/runtime.h>

typedef uint32_t FLTypeID;

@interface FLType : NSObject<NSCopying> {
@private
    NSString* _typeName;
    Class _classForType;
    SEL _encodeSelector;
    SEL _decodeSelector;
}

@property (readonly, strong, nonatomic) NSString* typeName;
@property (readonly, assign, nonatomic) Class classForType;

- (id) initWithClass:(Class) aClass;

- (id) initWithClass:(Class) aClass 
        withTypeName:(NSString*) typeName;

- (id) initWithClass:(Class) aClass 
        withTypeName:(NSString*) typeName 
             encoder:(SEL) encoder 
             decoder:(SEL) decoder;

+ (id) typeWithClass:(Class) aClass;

// encoding overrides (by default these call the encode/decoder selectors
@property (readonly, assign, nonatomic) SEL encodeSelector;
@property (readonly, assign, nonatomic) SEL decodeSelector;

// optional overrides.
- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;

+ (SEL) decodeSelectorForClass:(Class) aClass;
+ (SEL) encodeSelectorForClass:(Class) aClass;
@end

// Enum Type (special case for a number)

//@interface FLEnumType : FLType
//@end

// encoding


@interface NSObject (FLType)
+ (FLType*) type;
- (FLType*) type;
@end

