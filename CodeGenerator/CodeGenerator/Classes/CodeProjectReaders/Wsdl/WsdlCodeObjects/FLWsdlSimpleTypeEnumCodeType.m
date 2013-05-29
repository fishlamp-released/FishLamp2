//
//  FLWsdlSimpleTypeEnumCodeType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlSimpleTypeEnumCodeType.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlSimpleType.h"
#import "FLWsdlEnumeration.h"
#import "FLWsdlRestrictionArray.h"
#import "FLWsdlList.h"
#import "FLWsdlCodeEnum.h"

@implementation FLWsdlSimpleTypeEnumCodeType

+ (id) wsdlSimpleTypeEnumCodeType:(FLWsdlSimpleType*) simpleType
                     optionalName:(NSString*) optionalName {
	
    FLWsdlSimpleTypeEnumCodeType* enumType = FLAutorelease([[[self class] alloc] init]);
    enumType.typeName = optionalName ? optionalName : simpleType.name;

    for(FLWsdlEnumeration* wsdlEnum in simpleType.restriction.enumerations) {
        [enumType addEnum:wsdlEnum.value enumValue:nil];
    }
	
	return enumType;
}



@end
