//
//  FLWsdlPortCodeObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlPortCodeObject.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlPortType.h"
#import "FLWsdlOperationCodeObject.h"
#import "FLWsdlCodeMethod.h"
#import "FLCodeLine.h"

@implementation FLWsdlPortCodeObject

+ (id) wsdlPortCodeObject:(FLWsdlPortType*) portType codeReader:(FLWsdlCodeProjectReader*) codeReader {

    FLWsdlPortCodeObject* object = [FLWsdlPortCodeObject wsdlCodeObject:portType.name superclassName:nil];
    
    
    return object;
}

- (void) addOperationCodeObject:(FLWsdlOperationCodeObject*) operation {
    FLWsdlCodeMethod* method = [self addMethod:operation.className methodReturnType:operation.className];
    
    FLCodeLine* codeLine = [FLCodeLine codeLine:FLCodeLineTypeReturnNewObject];
    [codeLine addParameter:operation.className forKey:FLCodeLineClassName];
    [method.codeLines addObject:codeLine];
}


@end
