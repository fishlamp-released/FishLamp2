//
//  FLObjcName.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeIdentifier.h"

@interface FLObjcName : FLCodeIdentifier 

//+ (id) objcName:(NSString*) name  prefix:(NSString*) prefix suffix:(NSString*) suffix;
//+ (id) objcName:(NSString*) name;

@end

@interface FLObjcIvarName : FLObjcName 
+ (id) objcIvarName:(NSString*) ivarName;
@end

@interface FLObjcClassName : FLObjcName 
+ (id) objcClassName:(NSString*) className prefix:(NSString*) prefix;
@end

@interface FLObjcMethodName : FLObjcName
+ (id) objcMethodName:(NSString*) methodName;
@end

@interface FLObjcPropertyName : FLObjcName
+ (id) objcPropertyName:(NSString*) propertyName;
@end

@interface FLObjcImportedName : FLObjcName 
+ (id) objcImportedName:(NSString*) importedName;
@end

@interface FLObjcEnumName : FLObjcName 
+ (id) objcEnumName:(NSString*) name prefix:(NSString*) prefix;
@end

@interface FLObjcEnumValueName : FLObjcName 
+ (id) objcEnumValueName:(NSString*) name  prefix:(NSString*) prefix;
@end

@interface FLObjcParameterName : FLObjcName
+ (id) objcParameterName:(NSString*) name;
@end

//@interface FLObjcVariableName : FLObjcName {
//}
//
//@end
//
//@interface FLObjcParameterName : FLObjcName
//@end


