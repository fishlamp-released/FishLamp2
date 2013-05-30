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
#import "FLCodeObject+Additions.h"
#import "FLWsdlDefinitions.h"

@implementation FLWsdlBindingCodeObject

+ (FLCodeProperty*) addBindingOperationProperty:(FLWsdlOperation*) operation toObject:(FLWsdlCodeObject*) object {

	FLCodeProperty* prop = [object addProperty:operation.name propertyType:@"string"];
	prop.isImmutable = YES;
	
	if(operation.operation) {
		FLWsdlOperation* childOperation = operation.operation;
	
		if(FLStringIsNotEmpty(childOperation.soapAction)) {
			prop.defaultValue = [FLCodeLine codeLineReturnString:childOperation.soapAction];
		}
		else if(FLStringIsNotEmpty(childOperation.location)) {
			prop.defaultValue = [FLCodeLine codeLineReturnString:childOperation.location];
		}
	}
	
	
	return prop;
}


+ (id) wsdlBindingCodeObject:(FLWsdlBinding*) binding codeReader:(FLWsdlCodeProjectReader*) reader {

    NSString* url = [reader servicePortLocationFromBinding:binding];		   
    FLConfirmStringIsNotEmpty(url);
    
    NSString* targetNamespace = reader.wsdlDefinitions.targetNamespace;
    FLConfirmStringIsNotEmpty(targetNamespace);

	FLWsdlCodeObject* object = [FLWsdlBindingCodeObject wsdlCodeObject:binding.name superclassName:@"FLNetworkServerContext"];
	object.isSingleton = YES;
	
	FLCodeProperty* urlProp = [object addProperty:@"url" propertyType:@"string"];
	urlProp.isImmutable = YES;
	urlProp.defaultValue = [FLCodeLine codeLineReturnString:targetNamespace];

	FLCodeProperty* targetNamespaceProp = [object addProperty:@"targetNamespace" propertyType:@"string"];
	targetNamespaceProp.defaultValue = [FLCodeLine codeLineReturnString:targetNamespace];
	targetNamespaceProp.isImmutable = YES;
			
	NSMutableDictionary* initValues = [NSMutableDictionary dictionary];
	[initValues setObject:url forKey:FLNetworkServerPropertyKeyUrl];
	[initValues setObject:targetNamespace forKey:FLNetworkServerPropertyKeyTargetNamespace];

	for(FLWsdlOperation* op in binding.operations) {
		FLCodeProperty* prop = [self addBindingOperationProperty:op toObject:object];
        [initValues setObject:prop.defaultValue forKey:prop.name];
	}

	for(NSString* key in initValues) {
		NSString* value = [initValues objectForKey:key];
        [object addInitLine:[NSString stringWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", value, key]];
	}
    
    return object;
}




@end
