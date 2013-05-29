//
//  FLObjcName.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcName.h"
#import "FLStringUtils.h"

@implementation FLObjcName

//+ (id) objcName:(NSString*) name  prefix:(NSString*) prefix suffix:(NSString*) suffix {
//    return FLAutorelease([[self class] alloc] initWithIdentifierName:name prefix:prefix suffix:suffix]);
//}
//
//+ (id) objcName:(NSString*) name {
//    return FLAutorelease([[[self class] alloc] initWithIdentifierName:name prefix:nil suffix:nil]);
//}

@end

@implementation FLObjcIvarName 
+ (id) objcIvarName:(NSString*) ivarName {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:ivarName prefix:@"_" suffix:nil]);
}

- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@%@", self.prefix, [self.identifierName stringWithLowercaseFirstLetter], self.suffix];
}

@end

@implementation FLObjcClassName 
+ (id) objcClassName:(NSString*) className prefix:(NSString*) prefix {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:className prefix:prefix suffix:nil]);
}

- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@%@", self.prefix, [self.identifierName stringWithUpperCaseFirstLetter], self.suffix];
}

@end

@implementation FLObjcMethodName : FLObjcName
+ (id) objcMethodName:(NSString*) methodName {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:methodName prefix:nil suffix:nil]);
}

- (NSString*) generatedName {
    return [[super generatedName] stringWithLowercaseFirstLetter];
}

@end

@implementation FLObjcPropertyName : FLObjcName
+ (id) objcPropertyName:(NSString*) propertyName {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:propertyName prefix:nil suffix:nil]);
}

- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@%@", self.prefix, [self.identifierName stringWithLowercaseFirstLetter], self.suffix];
}

@end


@implementation FLObjcImportedName : FLObjcName 
+ (id) objcImportedName:(NSString*) importedName{
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:importedName prefix:nil suffix:nil]);
}
@end

@implementation FLObjcEnumName : FLObjcName 
+ (id) objcEnumName:(NSString*) importedName  prefix:(NSString*) prefix{
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:importedName prefix:prefix suffix:nil]);
}
@end

@implementation FLObjcEnumValueName : FLObjcName 
+ (id) objcEnumValueName:(NSString*) name prefix:(NSString*) prefix {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:name prefix:prefix suffix:nil]);
}
- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@", self.prefix, [self.identifierName stringWithUpperCaseFirstLetter]];
}
@end

@implementation FLObjcParameterName : FLObjcName 
+ (id) objcParameterName:(NSString*) parameterName {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:parameterName prefix:nil suffix:nil]);
}
@end