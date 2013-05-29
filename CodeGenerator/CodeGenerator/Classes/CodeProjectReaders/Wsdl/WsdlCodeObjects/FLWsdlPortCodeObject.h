//
//  FLWsdlPortCodeObject.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeObject.h"
@class FLWsdlCodeProjectReader;
@class FLWsdlPortType;
@class FLWsdlOperationCodeObject;

@interface FLWsdlPortCodeObject : FLWsdlCodeObject

+ (id) wsdlPortCodeObject:(FLWsdlPortType*) portType codeReader:(FLWsdlCodeProjectReader*) codeReader;

- (void) addOperationCodeObject:(FLWsdlOperationCodeObject*) operation;

@end
