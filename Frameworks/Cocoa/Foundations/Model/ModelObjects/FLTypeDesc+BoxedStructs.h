//
//  FLTypeDesc+BoxedStructs.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

// included by FLTypeDesc.h

enum  {
	FLTypeDescPoint                = 'poin',
	FLTypeDescRect                 = 'rect',
	FLTypeDescSize                 = 'size',
};

@interface FLTypeDesc (BoxedStructs)
+ (id) pointType;
+ (id) rectType;
+ (id) sizeType;
@end

@interface FLBoxedStructTypeDesc :FLTypeDesc
@end

@interface FLRectTypeDesc : FLBoxedStructTypeDesc
@end
@interface FLPointTypeDesc : FLBoxedStructTypeDesc
@end
@interface FLSizeTypeDesc : FLBoxedStructTypeDesc
@end

@protocol FLTypeDescBoxedStructEncoding <NSObject>
- (NSString*) encodeStringWithRectValue:(NSValue*) rect;
- (NSValue*) decodeRectValueFromString:(NSString*) string;

- (NSString*) encodeStringWithPointValue:(NSValue*) point;
- (NSValue*) decodePointValueFromString:(NSString*) string;

- (NSString*) encodeStringWithSizeValue:(NSValue*) size;
- (NSValue*) decodeSizeValueFromString:(NSString*) string;
@end

#define FLDataTypePoint [FLTypeDesc pointType]
#define FLDataTypeRect [FLTypeDesc rectType]
#define FLDataTypeSize [FLTypeDesc sizeType]
