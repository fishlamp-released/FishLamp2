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

@interface FLWsdlOperationCodeObject : FLWsdlCodeObject {

}

+ (id) wsdlOperationCodeObject:(FLWsdlOperation*) operation portType:(FLWsdlPortType*) portType  codeReader:(FLWsdlCodeProjectReader*) codeReader;

@end