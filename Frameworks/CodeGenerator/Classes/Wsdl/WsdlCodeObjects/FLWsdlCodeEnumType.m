//
//  FLWsdlCodeEnumType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeEnumType.h"
#import "FLWsdlCodeEnum.h"
#import "FLWsdlCodeProjectReader.h"

@implementation FLWsdlCodeEnumType

- (FLWsdlCodeEnum*) addEnum:(NSString*) theEnum enumValue:(NSString*) enumValueOrNil {
    FLWsdlCodeEnum* newEnum = [FLWsdlCodeEnum wsdlCodeEnum:theEnum];
    if(FLStringIsNotEmpty(enumValueOrNil)) {
        newEnum.value = [enumValueOrNil integerValue];
    }
        
    [self.enums addObject:newEnum];
    return newEnum;
}

- (void) setTypeName:(NSString*) typeName {
    [super setTypeName:FLDeleteNamespacePrefix(typeName)];
    FLConfirmStringIsNotEmptyWithComment(self.typeName, @"enumType needs a typeName");
}

@end
