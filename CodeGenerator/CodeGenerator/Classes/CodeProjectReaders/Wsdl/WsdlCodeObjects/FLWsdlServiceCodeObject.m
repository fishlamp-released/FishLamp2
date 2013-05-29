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
#import "FLWsdlPortCodeObject.h"
#import "FLWsdlCodeProperty.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlServiceAddress.h"

@implementation FLWsdlServiceCodeObject

+ (id) wsdlServiceCodeObject:(FLWsdlService*) service codeReader:(FLWsdlCodeProjectReader*) reader {
    FLWsdlServiceCodeObject* object = [FLWsdlServiceCodeObject wsdlCodeObject:service.name superclassName:nil];
    object.comment = service.documentation; 
    
    for(FLWsdlPortType* portType in service.ports) {
        FLWsdlPortCodeObject* portCodeObject = [reader portObjectForName:portType.name];
        
        if(FLStringIsNotEmpty(portType.address.location)) {
            FLWsdlCodeProperty* location = [portCodeObject addProperty:@"location" propertyType:@"string"];
            location.isImmutable = YES;
            location.isReadOnly = YES;
            location.defaultValue = portType.address.location;
        }
        
        [object addMethod:portType.name methodReturnType:portCodeObject.className];
        
        
    }
    
    return object;

}
@end
