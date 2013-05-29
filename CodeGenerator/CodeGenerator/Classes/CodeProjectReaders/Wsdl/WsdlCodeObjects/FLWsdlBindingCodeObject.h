//
//  FLWsdlBindingCodeObject.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeObject.h"
@class FLWsdlBinding;
@class FLWsdlCodeProjectReader;

@interface FLWsdlBindingCodeObject : FLWsdlCodeObject

+ (id) wsdlBindingCodeObject:(FLWsdlBinding*) binding 
                  codeReader:(FLWsdlCodeProjectReader*) reader;
                         
@end
