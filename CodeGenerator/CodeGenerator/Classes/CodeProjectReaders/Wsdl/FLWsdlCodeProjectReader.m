//
//	FLWsdlCodeGenerator.m
//	PackMule
//
//	Created by Mike Fullerton on 8/9/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

//#import "FLCodeGenerator.h"

#import "FLWsdlCodeProjectReader.h"
#import "FLCodeProjectLocation.h"
#import "FLWsdlObjects.h"
#import "FLCodeProject.h"
#import "FLSoapParser.h"
#import "FLXmlObjectBuilder.h"
#import "FLSoapObjectBuilder.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeBuilder.h"
#import "FLCodeGeneratorErrors.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLSoapParser.h"
#import "FLStringUtils.h"
#import "FLXmlDocumentBuilder.h"
#import "FLNetworkServerContext.h"
#import "FLStringUtils.h"
#import "FLCodeProperty.h"

#import "FLWsdlCodeObject.h"
#import "FLWsdlCodeProperty.h"
#import "FLWsdlCodeArray.h"
#import "FLWsdlCodeMethod.h"
#import "FLWsdlCodeEnumType.h"
#import "FLWsdlSimpleTypeEnumCodeType.h"
#import "FLWsdlComplexTypeCodeObject.h"
#import "FLWsdlMessageCodeObject.h"
#import "FLWsdlBindingCodeObject.h"
#import "FLWsdlPortTypeCodeObject.h"
#import "FLWsdlOperationCodeObject.h"
#import "FLWsdlPortCodeObject.h"
#import "FLWsdlServiceCodeObject.h"

@interface FLWsdlCodeProjectReader ()
//@property (readwrite, assign, nonatomic) FLCodeProject* project;
@property (readwrite, strong, nonatomic) FLWsdlDefinitions* wsdlDefinitions;
//@property (readwrite, strong, nonatomic) FLCodeBuilder* output;
@end

@implementation FLWsdlCodeProjectReader
@synthesize wsdlDefinitions = _wsdlDefinitions;

- (id) init {
	if((self = [super init])) {
        _objects = [[NSMutableDictionary alloc] init];
        _messages = [[NSMutableDictionary alloc] init];
        _enums = [[NSMutableDictionary alloc] init];
        _arrays = [[NSMutableDictionary alloc] init];
        _declaredTypes = [[NSMutableDictionary alloc] init];
        _bindingObjects = [[NSMutableDictionary alloc] init];
        _portObjects = [[NSMutableDictionary alloc] init];
	}
	return self;
}

#if FL_DEALLOC
- (void) dealloc {	
    [_portObjects release];
    [_bindingObjects release];
    [_declaredTypes release];
	[_array release];
    [_enums release];
    [_objects release];
	[_wsdlDefinitions release];
	[super dealloc];
}
#endif


- (FLWsdlCodeObject*) codeObjectForClassName:(NSString*) key {
    return [_objects objectForKey:FLStringToKey(key)];
}

- (void) setCodeObject:(FLWsdlCodeObject*) object forKey:(NSString*) key {
    [_objects setObject:object forKey:FLStringToKey(key)];
}

- (void) addCodeObject:(FLWsdlCodeObject*) object {
    FLConfirmStringIsNotEmptyWithComment(object.className, @"object has no className");

    [self setCodeObject:object forKey:FLStringToKey(object.className)];
}

- (FLCodeEnumType*) enumForKey:(NSString*) key {
    return [_enums objectForKey:FLStringToKey(key)];
}

- (void) setEnum:(FLCodeEnumType*) theEnum forKey:(NSString*) key {
    [_enums setObject:theEnum forKey:FLStringToKey(key)];
}


- (void) addCodeEnum:(FLWsdlCodeEnumType*) enumType {
    [_enums setObject:enumType forKey:FLStringToKey(enumType.typeName)];
}

- (void) addArray:(FLWsdlCodeArray*) array {
    [_arrays setObject:array forKey:FLStringToKey(array.name)];
}

- (FLWsdlCodeArray*) arrayForName:(NSString*) name {
    return [_arrays objectForKey:FLStringToKey(name)];
}


- (BOOL) isEnum:(FLWsdlElement*) element {
	FLConfirmNotNil(element);
    
    return [self enumForKey:FLStringToKey(element.type)];
    

//
//	for(FLCodeEnumType* anEnum in self.project.enumTypes) {
//		if([anEnum.typeName isEqualToString:element.type]) {
//			return YES;
//		}
//	}
//	
//	return NO;
}

- (void) createObjectFromComplexType:(FLWsdlComplexType*) complexType 
                                type:(NSString*) type {
	if(!type) {
		type = complexType.name;
	}
	
	FLConfirmStringIsNotEmpty(type);

	if([complexType complexContent]) {
		if([complexType.complexContent extension]) {
			FLConfirmStringIsNotEmpty(complexType.complexContent.extension.base);

			FLWsdlCodeObject* object = [FLWsdlComplexTypeCodeObject wsdlCodeObject:type 
                                                         superclassName:complexType.complexContent.extension.base];
                                                         
            [object appendElementArrayAsProperties:complexType.complexContent.extension.sequence.elements codeReader:self];
            [self addCodeObject:object];
		}
		else if([complexType.complexContent restriction]) {
			BOOL isArray = complexType.complexContent.restriction.sequence.elements &&
						[[[complexType.complexContent.restriction.sequence.elements objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
		
			if(isArray) {
				FLWsdlCodeArray* array = [FLWsdlCodeArray wsdlCodeArray:type];
				   
				for(FLWsdlElement* obj in complexType.complexContent.restriction.sequence.elements) {	  
                    [array addContainedType:obj.type identifier:obj.name];
				}
                
                [self addArray:array];
			}
		}
	}
	else if(complexType.sequence.elements) {
		
        BOOL isArray = complexType.sequence.elements.count == 1 && 
			[[[complexType.sequence.elements objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
				
		if(isArray) {
            FLWsdlCodeArray* array = [FLWsdlCodeArray wsdlCodeArray:type];
							   
			for(FLWsdlElement* obj in complexType.sequence.elements) {	  
                [array addContainedType:obj.type identifier:obj.name];
			}
		
			[self addArray:array];
		}
		else {
			FLWsdlCodeObject* object = [FLWsdlComplexTypeCodeObject wsdlCodeObject:type superclassName:nil];
            
            [object appendElementArrayAsProperties:complexType.sequence.elements codeReader:self];
            
            [self addCodeObject:object];
		}
	}
	else if([complexType choice]) {
        FLWsdlCodeArray* array = [FLWsdlCodeArray wsdlCodeArray:type];
					   
		for(FLWsdlElement* obj in complexType.choice.elements) {	  
			[array addContainedType:obj.type identifier:obj.name];
		}
	
		[self addArray:array];
	}
	else {
// create empty object? 
		FLWsdlCodeObject* object = [FLWsdlComplexTypeCodeObject wsdlCodeObject:type superclassName:nil];
		[self addCodeObject:object];
	}
}

- (BOOL) partTypeIsObject:(FLWsdlPart*) part
{
	NSString* partType = nil;
	if(FLStringIsNotEmpty(part.type)) {
		partType = part.type;
	}
	else if(FLStringIsNotEmpty(part.element)) {
		partType = part.element;
	}
	
	FLConfirmNotNil(partType);

	return [self codeObjectForClassName:partType] != nil;
}

- (FLWsdlMessage*) wsdlMessageForName:(NSString*) name  {
	name = FLStringToKey(name);

	for(FLWsdlMessage* msg in self.wsdlDefinitions.messages) {
		if([FLStringToKey(msg.name) isEqualToString:name]) {
			return msg;
		}
	}
	
	FLConfirmationFailureWithComment(@"Didn't find expected message object %@ (object referenced but not defined)", name);
	
	return nil;
}  

- (NSString*) servicePortLocationFromBinding:(FLWsdlBinding*) binding {
	FLConfirmStringIsNotEmpty(binding.name);
	
	// this is attempting to get the binding attribute from the port element
	// in the superclass service element, using the name of the bindings array
	// e.g. the point it to get the location url from the address element
	// and return it
	
/*
	<wsdl:service name="AmazonSimpleDB">
		<wsdl:documentation>
			Amazon SimpleDB is a web service for running queries on structured
			data in real time. This service works in close conjunction with Amazon 
			Simple Storage Service (Amazon S3) and Amazon Elastic Compute Cloud 
			(Amazon EC2), collectively providing the ability to store, process 
			and query data sets in the cloud. These services are designed to make 
			web-scale computing easier and more cost-effective for developers.

			Traditionally, this type of functionality has been accomplished with 
			a clustered relational database that requires a sizable upfront 
			investment, brings more complexity than is typically needed, and often 
			requires a DBA to maintain and administer. In contrast, Amazon SimpleDB 
			is easy to use and provides the core functionality of a database - 
			real-time lookup and simple querying of structured data without the 
			operational complexity.	 Amazon SimpleDB requires no schema, automatically 
			indexes your data and provides a simple API for storage and access.	 
			This eliminates the administrative burden of data modeling, index 
			maintenance, and performance tuning. Developers gain access to this 
			functionality within Amazon's proven computing environment, are able 
			to scale instantly, and pay only for what they use. 
		</wsdl:documentation>
		<wsdl:port name="AmazonSDBPortType" binding="tns:AmazonSDBBinding">
			<soap:address location="https://sdb.amazonaws.com"/>
		</wsdl:port>
	</wsdl:service>

*/				
	for(FLWsdlPortType* port in self.wsdlDefinitions.service.ports) {
		if([port.binding isEqualToString:binding.type]) {
			return port.address.location;
		}
	}
	
    FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeTranslatorFailed, @"Service location string not found in service %@", self.wsdlDefinitions.service.name);
	return nil;
}



+ (FLWsdlCodeProjectReader*) wsdlCodeReader {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location {
    return [location isLocationType:FLCodeProjectLocationTypeWsdl];
}

- (void) addEnumerationsInSimpleTypes:(NSArray*) simpleTypes {
    for(FLWsdlSimpleType* simpleType in simpleTypes) {
    
        if([simpleType restriction]) {
            [self addCodeEnum:[FLWsdlSimpleTypeEnumCodeType wsdlSimpleTypeEnumCodeType:simpleType optionalName:nil]];
        }

        if([simpleType list]) {
            [self addCodeEnum:[FLWsdlSimpleTypeEnumCodeType wsdlSimpleTypeEnumCodeType:simpleType optionalName:simpleType.name]];
        }
    }
}

- (void) addObjectsInComplexTypes:(NSArray*) complexTypes {
    for(FLWsdlComplexType* complexType in complexTypes) {
        [self createObjectFromComplexType:complexType type:nil];
    }
}

- (void) addObjectsFromElements:(NSArray*) elements {
    for(FLWsdlElement* element in elements) {
        if([element complexType]) {
            [self createObjectFromComplexType:element.complexType type:element.name];
        }
        else {
            [_declaredTypes setObject:[FLWsdlCodeObject wsdlCodeObject:element.name superclassName:element.type] forKey:FLStringToKey(element.type)];
        
//            FLLog(@"Skipping element with no complexType content: name:%@, type:%@", element.name, element.type);
        }
    }
}

- (void) addMessageObject:(FLWsdlMessageCodeObject*) object {
    [_messages setObject:object forKey:FLStringToKey(object.className)];
    [_objects setObject:object forKey:FLStringToKey(object.className)];
}

- (void) addMessageObjects:(NSArray*) messages {

    for(FLWsdlMessage* message in messages) {
        if(message.parts.count == 1) {	
            FLWsdlPart* part = [message.parts objectAtIndex:0];
            
            if(FLStringIsNotEmpty(part.element)) {
                // this means we'll be using a different object here, and we don't need a message object.
                // this is for an input/output object

                // note that this if for wsdl:part that has elements, not type.
                
    //			  <wsdl:message name="GetChallengeSoapIn">
    //			  <wsdl:part name="parameters" element="tns:GetChallenge"/>
    //			  </wsdl:message>

                FLLog(@"skipping part - name:%@, element: %@", part.name, part.element);
                
                continue;
            }
        }

        [self addMessageObject:[FLWsdlMessageCodeObject wsdlMessageCodeObject:message]];
	}
}

- (void) addBindingObject:(FLWsdlBindingCodeObject*) bindingObject {
    [_bindingObjects setObject:bindingObject forKey:FLStringToKey(bindingObject.className)];
    [_objects setObject:bindingObject forKey:FLStringToKey(bindingObject.className)];
}

- (void) addBindingObjects:(NSArray*) bindings {
	for(FLWsdlBinding* binding in bindings) {
        [self addBindingObject:[FLWsdlBindingCodeObject wsdlBindingCodeObject:binding codeReader:self]];
	}
}

- (void) addPortObject:(FLWsdlOperationCodeObject*) portObject {
    [_portObjects setObject:portObject forKey:FLStringToKey(portObject.className)];
    [_objects setObject:portObject forKey:FLStringToKey(portObject.className)];

}

- (FLWsdlPortCodeObject*) portObjectForName:(NSString*) name {
    return [_portObjects objectForKey:FLStringToKey(name)];
}

- (void) addPortObjects:(NSArray*) portTypes {
    for(FLWsdlPortType* portType in portTypes) {
        
        FLWsdlPortCodeObject* portObject = [FLWsdlPortCodeObject wsdlPortCodeObject:portType codeReader:self];
    
		for(FLWsdlOperation* operation in portType.operations) {
            FLWsdlOperationCodeObject* operationCodeObject =
                [FLWsdlOperationCodeObject wsdlOperationCodeObject:operation portType:portType codeReader:self];

            [self addCodeObject:operationCodeObject];
            
            [portObject addOperationCodeObject:operationCodeObject];
		}

        [self addCodeObject:portObject];
	}
}

- (void) addServiceObject:(FLWsdlService*) service {
    [self addCodeObject:[FLWsdlServiceCodeObject wsdlServiceCodeObject:service codeReader:self]];
}

- (FLCodeProject *)readProjectFromLocation:(FLCodeProjectLocation *)descriptor {

	NSData* xml = [descriptor loadDataInResource];

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:xml];

    self.wsdlDefinitions = [FLWsdlDefinitions objectWithXmlElement:parsedSoap withObjectBuilder:[FLSoapObjectBuilder instance]];
	

// TODO: abstract away objc

//	FLCodeTypeDefinition* define1 = [FLCodeTypeDefinition typeDefinition];
//	define1.typeName = @"FLNetworkServerContext";
//	define1.import = @"FLNetworkServerContext.h";
//	[self.project.typeDefinitions addObject:define1];
//
//	FLCodeTypeDefinition* define2 = [FLCodeTypeDefinition typeDefinition];
//	define2.typeName = @"FLHttpOperation";
//	define2.import = @"FLHttpOperation.h";
//	[self.project.typeDefinitions addObject:define2];

//	FLTypeDefinition* define3 = [FLTypeDefinition TypeDefinition];
//	define3.typeName = @"FLNetworkEndpointHelper";
//	define3.import @"FLNetworkEndpointHelper.h";
//	[project.typeDefinitions addObject:define3];

	
	for(FLWsdlSchema* schema in self.wsdlDefinitions.types) {
        [self addEnumerationsInSimpleTypes:schema.simpleTypes];
        [self addObjectsInComplexTypes:schema.complexTypes];
        [self addObjectsFromElements:schema.elements];
	}
    
    [self addMessageObjects:self.wsdlDefinitions.messages];
    [self addBindingObjects:self.wsdlDefinitions.bindings];
    [self addPortObjects:self.wsdlDefinitions.portTypes];

    [self addServiceObject:self.wsdlDefinitions.service];

    FLCodeProject* project = [FLCodeProject project];
	if(FLStringIsNotEmpty(self.wsdlDefinitions.documentation)) {
		project.comment = self.wsdlDefinitions.documentation;
	}
    [project.objects addObjectsFromArray:[_objects allValues]];
    [project.arrays addObjectsFromArray:[_arrays allValues]];
    [project.enumTypes addObjectsFromArray:[_enums allValues]];

    return project;

}




@end

