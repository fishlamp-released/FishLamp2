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
    Class _classForType;
    SEL _encodeSelector;
    SEL _decodeSelector;
}

@property (readonly, strong, nonatomic) NSString* typeName;
@property (readonly, assign, nonatomic) Class classForType;

- (id) initWithClass:(Class) aClass ;
- (id) initWithClass:(Class) aClass encoder:(SEL) encoder decoder:(SEL) decoder;

+ (id) typeWithClass:(Class) aClass;

// inflation helpers
+ (id) registeredTypeForName:(NSString*) string;
+ (void) registerType:(FLType*) desc;
- (void) registerSelf;

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

@protocol FLTypeCoreTypesEncoding <NSObject>
- (NSString*) encodeStringWithCGRect:(NSValue*) value;
- (NSString*) encodeStringWithCGPoint:(NSValue*) value;
- (NSString*) encodeStringWithCGSize:(NSValue*) value;

- (NSString*) encodeStringWithNSNumber:(NSNumber*) number;
- (NSString*) encodeStringWithNSString:(NSString*) string;
- (NSString*) encodeStringWithNSDate:(NSDate*) date;
- (NSString*) encodeStringWithNSData:(NSData*) data;
- (NSString*) encodeStringWithNSURL:(NSURL*) URL;

- (NSString*) encodeStringWithBOOL:(NSNumber*) number;
@end

// decoding

@protocol FLTypeCoreTypesDecoding <NSObject>
- (NSValue*) decodeCGPointFromString:(NSString*) string;
- (NSValue*) decodeCGRectFromString:(NSString*) string;
- (NSValue*) decodeCGSizeFromString:(NSString*) string;

- (NSNumber*) decodeBOOLFromString:(NSString*) string;
- (NSNumber*) decodeNSNumberFromString:(NSString*) string;
- (NSString*) decodeNSStringFromString:(NSString*) string;
- (NSDate*) decodeNSDateFromString:(NSString*) string;
- (NSData*) decodeNSDataFromString:(NSString*) string;
- (NSURL*) decodeNSURLFromString:(NSString*) string;
@end

@interface NSObject (FLType)
+ (FLType*) type;
- (FLType*) type;
@end

@interface FLNamedTyped : FLType {
@private
    NSString* _name;
}
@property (readonly, strong, nonatomic) NSString* name;
- (id) initWithName:(NSString*) name withClass:(Class) aClass;
- (id) initWithName:(NSString*) name withType:(FLType*) type;
+ (id) namedType:(NSString*) name withClass:(Class) aClass;
+ (id) namedType:(NSString*) name withType:(FLType*) type;
@end