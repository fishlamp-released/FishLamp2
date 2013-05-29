//
//  FLWsdlCodeObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeObject.h"
#import "FLWsdlCodeProperty.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlElement.h"
#import "FLWsdlCodeMethod.h"

@implementation FLWsdlCodeObject

- (id) initWithClassName:(NSString*) className superclassName:(NSString*) superclassName {	
	self = [super init];
	if(self) {
//		self.protocols = @"NSCoding, NSCopying";
        self.className = className;
		self.superclass = superclassName;
    }
	return self;
}

+ (id) wsdlCodeObject:(NSString*) className superclassName:(NSString*) superclassName {
    return FLAutorelease([[[self class] alloc] initWithClassName:className superclassName:superclassName]);
}

- (void) setClassName:(NSString*) className {
    [super setClassName:FLDeleteNamespacePrefix(className)];
    FLConfirmStringIsNotEmptyWithComment(self.className, @"object needs a className");
}

- (void) setSuperclass:(NSString*) className {
    [super setSuperclass:FLDeleteNamespacePrefix(className)];
}

- (void) appendElementArrayAsProperties:(NSArray*) elementArray codeReader:(FLWsdlCodeProjectReader*) codeReader {
	
    for(FLWsdlElement* obj in elementArray) {

		if([obj.maxOccurs isEqualToString:@"unbounded"]) {
            FLWsdlCodeProperty* prop = [self addProperty:[NSString stringWithFormat:@"%@Array", obj.name] propertyType:@"array"];
            [prop addContainedType:obj.type identifier:obj.name];
            
            
//			FLCodeArrayType* type = [FLCodeArrayType arrayType];
//			type.name = obj.name; //obj.name;
//			type.typeName = FLDeleteNamespacePrefix(obj.type);
//			[prop.arrayTypes addObject:type];
		}
		else if([codeReader isEnum:obj]) {
        
// TODO: ENUM PROPERTY        
            [self addProperty:obj.name propertyType:@"string"];
		}
		else if(FLStringIsNotEmpty(obj.ref)) {
            [self addProperty:obj.ref propertyType:obj.ref];
//			prop.name = obj.ref;
//			prop.type = FLDeleteNamespacePrefix(obj.ref);
		}
		else {
            [self addProperty:obj.name propertyType:obj.type];
//			prop.name = obj.name;
//			prop.type = FLDeleteNamespacePrefix(obj.type);
		}
	}
}

- (FLCodeProperty*) propertyForName:(NSString*) name {
//	FLCodeProperty* input = 

    name = FLStringToKey(name);

	for(FLCodeProperty* prop in self.properties) {
		if(FLStringsAreEqual(FLStringToKey(prop.name), name)) {
			return prop;
		}
	}

	return nil;
} 

- (FLWsdlCodeProperty*) addProperty:(NSString*) propertyName 
                       propertyType:(NSString*) propertyType {

    FLWsdlCodeProperty* property = [FLWsdlCodeProperty wsdlCodeProperty:propertyName propertyType:propertyType];
    
    FLAssertStringIsNotEmpty(property.name);
    FLAssertStringIsNotEmpty(property.type);
    
    [self.properties addObject:property];
    
    return property;
}                       

- (FLWsdlCodeMethod*) addMethod:(NSString*) methodName 
               methodReturnType:(NSString*) methodReturnType {

    FLWsdlCodeMethod* method = [FLWsdlCodeMethod wsdlCodeMethod:methodName methodReturnType:methodReturnType];
    [self.methods addObject:method];
    
    return method;
               
}




@end

