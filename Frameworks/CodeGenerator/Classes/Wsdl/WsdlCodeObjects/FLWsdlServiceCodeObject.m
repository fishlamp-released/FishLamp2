//
//  FLWsdlServiceCodeObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlServiceCodeObject.h"
#import "FLWsdlService.h"
#import "FLWsdlPortType.h"
#import "FLWsdlCodeProperty.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlServiceAddress.h"
#import "FLWsdlCodeMethod.h"

#if CODEGEN
#import "FLCodeElementsAll.h"
#endif
@implementation FLWsdlServiceCodeObject

+ (id) wsdlServiceCodeObject:(FLWsdlService*) service codeReader:(FLWsdlCodeProjectReader*) reader {
    FLWsdlServiceCodeObject* object = [FLWsdlServiceCodeObject wsdlCodeObject:service.name superclassName:nil];
    object.comment = service.documentation; 
    
    for(FLWsdlPortType* portType in service.ports) {
        FLWsdlCodeObject* portCodeObject = [reader codeObjectForClassName:portType.name];
        
        if(FLStringIsNotEmpty(portType.address.location)) {
            FLWsdlCodeProperty* location = [portCodeObject addProperty:@"location" propertyType:@"string"];
            location.isImmutable = YES;
            location.isPrivate = YES;
            location.isReadOnly = YES;
#if CODEGEN
            location.defaultValue = [FLCodeStatement codeStatement:
                                        [FLCodeReturn codeReturn:
                                            [FLCodeString codeString:portType.address.location]]];
#endif
        }
        
        FLWsdlCodeMethod* method =
            [object addMethod:[portType.name stringWithDeletedSubstring:service.name] methodReturnType:portCodeObject.name];

#if CODEGEN
        [method.codeLines addObject:[FLCodeStatement codeStatement:
                                        [FLCodeReturn codeReturn:
                                            [FLCodeCreateObject codeCreateObject:
                                                [FLCodeClassName codeClassName:portType.name]]]]];
#endif
    }
    
    return object;

}
@end
