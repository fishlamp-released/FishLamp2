//
//  FLTypeDesc+Objects.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

// included by FLTypeDesc.h

enum  {
    FLTypeDescGenericObject       = _C_ID,
    FLTypeDescSpecificObject      = _C_CLASS,
	FLTypeDescStringObject        = 'strg',
	FLTypeDescDateObject          = 'date',
	FLTypeDescDataObject          = 'data',
    FLTypeDescColor               = 'colr',
    FLTypeDescURLObject           = 'urlt',
    FLTypeDescSelector            = _C_SEL
}; 

@interface FLTypeDesc (Objects)
+ (id) objectType;
+ (id) objectTypeWithClass:(Class) typeClass;
+ (id) stringType;
+ (id) dateType;
+ (id) URLType;
@end

@interface FLGenericObjectTypeDesc : FLTypeDesc 
@end

@interface FLSpecificObjectTypeDesc : FLTypeDesc {
@private
    Class _typeClass;
}
@end

@interface FLStringTypeDesc : FLTypeDesc
@end

@interface FLDateTypeDesc : FLTypeDesc
@end

@interface FLURLTypeDesc : FLTypeDesc
@end

@protocol FLTypeDescObjectEncoding <NSObject>
- (NSString*) encodeStringWithString:(NSString*) string;
- (NSString*) decodeStringFromString:(NSString*) string;

- (NSString*) encodeStringWithDate:(NSDate*) date;
- (NSDate*) decodeDateFromString:(NSString*) string;

- (NSString*) encodeStringWithURL:(NSURL*) URL;
- (NSURL*) decodeURLFromString:(NSString*) string;

- (NSString*) encodeStringWithData:(NSData*) data;
- (NSData*) decodeDataFromString:(NSString*) string;

@end



// compatibility macros
#define FLDataTypeObject [FLTypeDesc objectType]
#define FLDataTypeString [FLTypeDesc stringType]
#define FLDataTypeDate [FLTypeDesc dateType]
#define FLDataTypeURL [FLTypeDesc URLType]


