//
//  FLObjcType.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLGenerated.h"
@class FLObjcName;

@interface FLObjcType : NSObject<FLGenerated, NSCopying> {
@private
    FLObjcName* _typeName;
    NSString* _importFileName;
}

- (id) initWithTypeName:(FLObjcName*) typeName 
         importFileName:(NSString*) importFileName;

@property (readonly, strong, nonatomic) FLObjcName* typeName;
@property (readonly, strong, nonatomic) NSString* importFileName;
@property (readonly, assign, nonatomic) BOOL isObject;
@end

@interface FLObjcObjectType : FLObjcType
         
+ (id) objcObjectType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName;

@end

// value types

@interface FLObjcValueType : FLObjcType
+ (id) objcValueType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName;
@end

@interface FLObjcEnumType : FLObjcType 
+ (id) objcEnumType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName;
@end

// other types

@interface FLObjcProtocolType : FLObjcType 
+ (id) objcProtocolType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName;

@end

@interface FLObjcAbstractObjectType : FLObjcType
+ (id) objcAbstractObjectType;
@end

@interface FLObjcVoidType : FLObjcType
+ (id) objcVoidType;
@end

@class FLObjcContainerSubType;
@interface FLObjcContainerType : FLObjcObjectType {
@private
    NSMutableArray* _containerSubTypes;
}
+ (id) objcContainerType;

@property (readonly, strong, nonatomic) NSArray* containerSubTypes;

- (void) addContainerSubType:(FLObjcContainerSubType*) subType;

@end

@interface FLObjcContainerSubType : NSObject {
@private
    NSString* _subTypeName;
    FLObjcType* _arrayElementType;
}

@property (readwrite, strong, nonatomic) NSString* subTypeName;
@property (readwrite, strong, nonatomic) FLObjcType* objcType;

+ (id) objcContainerSubType:(NSString*) name 
                   objcType:(FLObjcType*) objcType;

@end

@interface FLObjcNumberObjectType : FLObjcObjectType
+ (id) objcNumberObjectType;
@end

@interface FLObjcNumberValueType : FLObjcValueType
//+ (id) objcNumberValueType:(NSString*) numberType;
@end

@interface FLObjcBoolType : FLObjcType
+ (id) objcBoolType;
@end


@interface FLObjcGeometryType : FLObjcValueType
@end



