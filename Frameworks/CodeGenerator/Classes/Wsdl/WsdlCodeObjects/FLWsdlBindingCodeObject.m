//
//  FLWsdlBindingCodeObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlBindingCodeObject.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlCodeProperty.h"
#import "FLNetworkServerContext.h"
#import "FLWsdlBinding.h"
#import "FLWsdlOperation.h"
#import "FLWsdlDefinitions.h"
#import "FLWsdlOperationCodeObject.h"
#import "FLWsdlPortType.h"
#import "FLWsdlCodeMethod.h"

#import "FLHttpRequestDescriptor.h"
#if CODEGEN
#import "FLCodeElementsAll.h"
#endif

@implementation FLWsdlBindingCodeObject

- (void) addOperationProperty:(FLWsdlOperationCodeObject*) operationCodeObject {

    NSString* factoryName = [operationCodeObject.name stringWithDeletedSubstring:self.name];
    
    factoryName = [NSString stringWithFormat:@"create%@", [factoryName stringWithUppercaseFirstLetter]];
    
    if([self methodForName:factoryName] == nil) {
#if CODEGEN
        FLWsdlCodeMethod* method = [self addMethod:factoryName methodReturnType:operationCodeObject.name];
        [method.codeLines addObject:
            [FLCodeStatement codeStatement:
                [FLCodeReturn codeReturn:
                    [FLCodeCreateObject codeCreateObject:
                        [FLCodeClassName codeClassName:operationCodeObject.name]]]]];
#endif
//        [FLReturnNewObjectCodeLine returnNewObjectCodeLine:operationCodeObject.name]];
    }
}

- (void) addOperation:(FLWsdlOperation*) operation 
              binding:(FLWsdlBinding*) binding 
            className:(NSString*) className
       superclassName:(NSString*) superclassName 
           codeReader:(FLWsdlCodeProjectReader*) reader {

    FLWsdlOperationCodeObject* operationCodeObject = [FLWsdlOperationCodeObject wsdlOperationCodeObject:className];
    [operationCodeObject addPropertiesWithOperation:operation codeReader:reader];
    [operationCodeObject addPropertiesWithBinding:binding withOperation:operation codeReader:reader];
    operationCodeObject.superclass = superclassName;
    
    // may have already have been created, but that's ok.
    [reader addCodeObject:operationCodeObject];
    [self addOperationProperty:operationCodeObject];
}              

- (void) addPropertiesWithBinding:(FLWsdlBinding*) binding 
                       codeReader:(FLWsdlCodeProjectReader*) reader {

    NSString* url = [reader servicePortLocationFromBinding:binding];		   
    FLConfirmStringIsNotEmpty(url);
    
    NSString* targetNamespace = reader.wsdlDefinitions.targetNamespace;
    FLConfirmStringIsNotEmpty(targetNamespace);
    
	FLCodeProperty* urlProp = [self addProperty:@"url" propertyType:@"string"];
	urlProp.isImmutable = YES;
#if CODEGEN
	urlProp.defaultValue = [FLCodeStatement codeStatement:
                                [FLCodeReturn codeReturn:
                                    [FLCodeString codeString:url]]];

	FLCodeProperty* targetNamespaceProp = [self addProperty:@"targetNamespace" propertyType:@"string"];

	targetNamespaceProp.defaultValue = [FLCodeStatement codeStatement:
                                            [FLCodeReturn codeReturn:
                                                [FLCodeString codeString:targetNamespace]]];

	targetNamespaceProp.isImmutable = YES;
#endif
		
    BOOL isSoap =   FLStringIsNotEmpty(binding.binding.transport) && 
                    [binding.binding.transport rangeOfString:@"soap"].length > 0;
    
    
    if(isSoap) {
    
        for(FLWsdlOperation* operation  in binding.operations) {
            
            NSString* className = [NSString stringWithFormat:@"%@%@SoapRequest", binding.name, operation.name];
        
            [self addOperation:operation binding:binding className:className superclassName:@"FLSoapHttpRequest" codeReader:reader];
        }
    }
    else {
        for(FLWsdlOperation* operation  in binding.operations) {
            {
            NSString* className = [NSString stringWithFormat:@"%@%@XmlRequest", binding.name, operation.name];

            [self addOperation:operation binding:binding className:className superclassName:@"FLXmlHttpRequest" codeReader:reader];
            }
            {
            NSString* className = [NSString stringWithFormat:@"%@%@JsonRequest", binding.name, operation.name];

            [self addOperation:operation binding:binding className:className superclassName:@"FLJsonHttpRequest" codeReader:reader];
            }
        }
    }

}

- (void) addPropertiesWithPortType:(FLWsdlPortType*) portType 
                        codeReader:(FLWsdlCodeProjectReader*) reader {

//    for(FLWsdlOperation* operation in portType.operations) {
//        FLWsdlOperationCodeObject* operationCodeObject = 
//            [FLWsdlOperationCodeObject wsdlOperationCodeObject:operation 
//                                                   bindingName:portType.name 
//                                                    codeReader:reader];
//        // may have already have been created, but that's ok.
//        [reader addCodeObject:operationCodeObject];
//
//        [operationCodeObject addPropertiesWithPortType:portType codeReader:reader];
//        [self addOperationProperty:operationCodeObject];
//    }
}                              

+ (id) wsdlBindingCodeObject:(NSString*) name codeReader:(FLWsdlCodeProjectReader*) reader {

	FLWsdlBindingCodeObject* bindingObject = [reader codeObjectForClassName:name];
    
    if(!bindingObject) {
        bindingObject = [FLWsdlBindingCodeObject wsdlCodeObject:name superclassName:nil];
    }
 
    return bindingObject;
}

+ (id) wsdlBindingCodeObjectWithPortType:(FLWsdlPortType*) portType 
                              codeReader:(FLWsdlCodeProjectReader*) codeReader {

	FLWsdlBindingCodeObject* bindingObject = [self wsdlBindingCodeObject:portType.name codeReader:codeReader];
    [bindingObject addPropertiesWithPortType:portType  codeReader:codeReader];
    return bindingObject;
}                              


+ (id) wsdlBindingCodeObjectWithBinding:(FLWsdlBinding*) binding codeReader:(FLWsdlCodeProjectReader*) codeReader {

	FLWsdlBindingCodeObject* bindingObject = [self wsdlBindingCodeObject:binding.name codeReader:codeReader];
    [bindingObject addPropertiesWithBinding:binding codeReader:codeReader];
    return bindingObject;
}




@end
