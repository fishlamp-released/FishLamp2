//
//  FLWsdlOperationCodeObject.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeObject.h"
@class FLWsdlOperation;
@class FLWsdlPortType;
@class FLWsdlCodeProjectReader;
@class FLWsdlBinding;

@interface FLWsdlOperationCodeObject : FLWsdlCodeObject {

}

+ (NSString*) operationClassName:(NSString*) binding operationName:(NSString*) operationName;

+ (id) wsdlOperationCodeObject:(FLWsdlOperation*) operation 
                   bindingName:(NSString*) bindingName 
                    codeReader:(FLWsdlCodeProjectReader*) codeReader;

- (void) addPropertiesWithOperation:(FLWsdlOperation*) operation codeReader:(FLWsdlCodeProjectReader*) reader ;
- (void) addPropertiesWithPortType:(FLWsdlPortType*) portType  codeReader:(FLWsdlCodeProjectReader*) reader;

- (void) addPropertiesWithBinding:(FLWsdlBinding*) binding 
                    withOperation:(FLWsdlOperation*) operation 
                       codeReader:(FLWsdlCodeProjectReader*) reader;

@end