//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLTypeDesc.h"

#import <objc/runtime.h>

typedef uint32_t FLTypeID;

@interface FLTypeDesc : NSObject {
@private
    Class _typeClass;
//    FLTypeID _typeID;
    SEL _encodeSelector;
    SEL _decodeSelector;
}

//@property (readonly, assign, nonatomic) FLTypeID typeID;
@property (readonly, strong, nonatomic) NSString* typeName;
@property (readonly, assign, nonatomic) Class typeClass;

- (id) initWithClass:(Class) aClass ;
- (id) initWithClass:(Class) aClass encoder:(SEL) encoder decoder:(SEL) decoder;

+ (id) typeDescWithClass:(Class) aClass;
//+ (id) typeDescWithClass:(Class) aClass typeID:(FLTypeID) typeID;

// inflation helpers
+ (id) registeredTypeForName:(NSString*) string;
+ (void) registerTypeDesc:(FLTypeDesc*) desc;
- (void) registerSelf;

// encoding overrides (by default these call the encode/decoder selectors
@property (readonly, assign, nonatomic) SEL encodeSelector;
@property (readonly, assign, nonatomic) SEL decodeSelector;

// optional overrides.
- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder;
- (id) decodeStringToObject:(NSString*) object withDecoder:(id) decoder;
@end

// Enum Type (special case for a number)

//@interface FLEnumTypeDesc : FLTypeDesc
//@end

// encoding

@protocol FLTypeDescCoreTypesEncoding <NSObject>
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGRect:(NSValue*) value;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGPoint:(NSValue*) value;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGSize:(NSValue*) value;

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSNumber:(NSNumber*) number;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSString:(NSString*) string;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSDate:(NSDate*) date;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSData:(NSData*) data;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSURL:(NSURL*) URL;
@end

// decoding

@protocol FLTypeDescCoreTypesDecoding <NSObject>
- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGPointFromString:(NSString*) string;
- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGRectFromString:(NSString*) string;
- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGSizeFromString:(NSString*) string;

- (NSNumber*) typeDesc:(FLTypeDesc*) typeDesc decodeNSNumberFromString:(NSString*) string;
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc decodeNSStringFromString:(NSString*) string;
- (NSDate*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDateFromString:(NSString*) string;
- (NSData*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDataFromString:(NSString*) string;
- (NSURL*) typeDesc:(FLTypeDesc*) typeDesc decodeNSURLFromString:(NSString*) string;
@end

@interface NSObject (FLTypeDesc)
+ (FLTypeDesc*) typeDesc;
@end


