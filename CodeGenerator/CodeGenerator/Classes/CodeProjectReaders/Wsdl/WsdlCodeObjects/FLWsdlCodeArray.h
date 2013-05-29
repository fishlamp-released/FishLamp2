//
//  FLWsdlCodeArray.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeArray.h"

@class FLWsdlCodeArrayType;

@interface FLWsdlCodeArray : FLCodeArray

+ (id) wsdlCodeArray:(NSString*) arrayName;

- (void) addContainedType:(FLWsdlCodeArrayType*) type;
- (void) addContainedType:(NSString*) typeName identifier:(NSString*) identifier;

@end


