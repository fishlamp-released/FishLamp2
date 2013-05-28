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
#import "FLCodeType.h"
#import "FLCodeTypeDefinition.h"

@interface FLWsdlCodeProjectReader ()
- (FLCodeProject*) createProjectFromWsdlDefinitions:(FLParsedXmlElement*) definitions;
- (void) createObjectFromSimpleType:(FLParsedXmlElement*) simpleType 
                       optionalName:(NSString*) optionalName;
- (void) createObjectFromComplexType:(FLParsedXmlElement*) complexType 
                                type:(NSString*) type;
- (void) createObjectFromElement:(FLParsedXmlElement*) element;
- (void) createMessageObject:(FLParsedXmlElement*) element;
- (void) createServiceManager:(FLParsedXmlElement*) binding;

- (void) createNewOperationObject:(FLParsedXmlElement*) operation 
                         portName:(NSString*) portName;

@end

@implementation FLWsdlCodeProjectReader

+ (FLWsdlCodeProjectReader*) wsdlCodeReader {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location {
    return [location isLocationType:FLCodeProjectLocationTypeWsdl];
}

- (FLCodeProject *)readProjectFromLocation:(FLCodeProjectLocation *)descriptor {
	NSData* xml = [descriptor loadDataInResource];

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:xml];
    return [self createProjectFromWsdlDefinitions:parsedSoap];
}

#define ELEMENTS(obj, key) [[[obj elementForElementName:key] elements] objectEnumerator]
#define ElementArray(obj, key) [obj elementForElementName:key ]
#define ElementValue(obj, key) [[obj elementForElementName:key] elementValue]

- (FLCodeProject*) createProjectFromWsdlDefinitions:(FLParsedXmlElement*) soap {

    FLWsdlDefinitions* definitions = [FLWsdlDefinitions objectWithXmlElement:soap withObjectBuilder:[FLSoapObjectBuilder instance]];
    
    

//    FLSetObjectWithRetain(_soap, soap);
//    _project = [[FLCodeProject alloc] init];
//	_project.canLazyCreate = NO;
//
//// TODO: abstract away objc
//
//	FLCodeTypeDefinition* define1 = [FLCodeTypeDefinition typeDefinition];
//	define1.typeName = @"FLNetworkServerContext";
//	define1.import = @"FLNetworkServerContext.h";
//	[_project.typeDefinitions addObject:define1];
//
//	FLCodeTypeDefinition* define2 = [FLCodeTypeDefinition typeDefinition];
//	define2.typeName = @"FLHttpOperation";
//	define2.import = @"FLHttpOperation.h";
//	[_project.typeDefinitions addObject:define2];
//
////	FLTypeDefinition* define3 = [FLTypeDefinition TypeDefinition];
////	define3.typeName = @"FLNetworkEndpointHelper";
////	define3.import @"FLNetworkEndpointHelper.h";
////	[_project.typeDefinitions addObject:define3];
//    
//    FLParsedXmlElement* documentation = [_soap elementForElementName:@"documentation"];
//    if(FLStringIsNotEmpty(documentation.elementValue)) {
//		_project.comment = documentation.elementValue;
//	}
//
//    NSArray* elements = [soap elementAtPath:@"types/schema"];
//    for(NSParsedItem* item in _elements) {
//        if(item)
//    }
    

//	for(FLParsedXmlElement* element in ELEMENTS(typesElement, @"types")) {
//    
//		if(FLStringsAreEqual(element.elementName, @"simpleType")) {
//			[self createObjectFromSimpleType:element optionalName:nil];
//		}
//		if(FLStringsAreEqual(element.elementName, @"complexType")) {
//			[self createObjectFromComplexType:element type:nil];
//		}
//		if(FLStringsAreEqual(element.elementName, @"element")) {
//			[self createObjectFromElement:element];
//		}
//	}
    
//	for(FLParsedXmlElement* message in Elements(_soap, @"message")) {
//		[self createMessageObject:message];
//	}
//	for(FLParsedXmlElement* binding in Elements(_soap, @"binding")) {
//		[self createServiceManager:binding];  
//	}
//	for(FLParsedXmlElement* portType in Elements(_soap, @"portType")) {
//		for(FLParsedXmlElement* operation in Elements(portType, @"operation")) {
//			[self createNewOperationObject:operation portName:ElementValue(portType, @"name")];
//		}
//    }
//	for(FLWsdlPortType* portType in definitions.portTypes) {
//		for(FLWsdlOperation* operation in portType.operations) {
//			[self createNewOperationObject:operation portName:portType.name project:project];
//		}
//	}
//	
//	[self prepareObjects];
    
    return _project;
}

- (void) createObjectFromSimpleType:(FLParsedXmlElement*) simpleType               
                       optionalName:(NSString*) optionalName{
}

- (void) createObjectFromComplexType:(FLParsedXmlElement*) complexType 
                                type:(NSString*) type {
}                                

- (void) createObjectFromElement:(FLParsedXmlElement*) element {
}

- (void) createMessageObject:(FLParsedXmlElement*) element {

}

- (void) createServiceManager:(FLParsedXmlElement*) binding {
}

- (void) createNewOperationObject:(FLParsedXmlElement*) operation 
                         portName:(NSString*) portName {
                         
}                         


@end

#if REFACTOR

#import "FLWsdlCodeProjectReader.h"
#import "FLSoapParser.h"
#import "FLStringUtils.h"
#import "FLXmlDocumentBuilder.h"
#import "FLNetworkServerContext.h"
#import "FLStringUtils.h"

#import "FLCodeProperty.h"

@interface FLWsdlCodeProjectReader ()
@property (readwrite, assign, nonatomic) FLCodeProject* project;
@property (readwrite, strong, nonatomic) FLWsdlDefinitions* wsdlDefinitions;
@property (readwrite, strong, nonatomic) FLCodeBuilder* output;
//
//- (void) buildCodeGeneratorSchemaFromWsdlDefinitions:(FLWsdlDefinitions*) definitions 
//	project:(FLCodeProject*) project;
@end

@implementation FLWsdlCodeProjectReader

@synthesize project = _codeSchema;
@synthesize wsdlDefinitions = _definitions;
@synthesize output = _output;

- (id) init {
	if((self = [super init])) {
		_operations = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) _clear {

}

+ (FLWsdlCodeProjectReader*) wsdlCodeReader {
    return FLAutorelease([[FLWsdlCodeProjectReader alloc] init]);
}

#if FL_DEALLOC
- (void) dealloc {	
	[_operations release];
	[_codeSchema release];
	[_definitions release];
	[_output release];
	[super dealloc];
}
#endif

- (NSString*) fixTypeString:(NSString*) wsdlType {
	wsdlType = [FLSoapParser stringWithDeletedNamespacePrefix:wsdlType];
	return wsdlType;
}

- (BOOL) isEnum:(FLWsdlElement*) element {
	FLConfirmNotNil_(element);

	for(FLEnumType* anEnum in self.project.enumTypes) {
		if([anEnum.typeName isEqualToString:element.type]) {
			return YES;
		}
	}
	
	return NO;
}

- (void) appendElementArrayAsProperties:(FLObject*) bizObj elementArray:(NSArray*) elementArray
{
	for(FLWsdlElement* obj in elementArray) {
		FLProperty* prop = [FLProperty property];
		if([obj.maxOccurs isEqualToString:@"unbounded"]) {
		//	FLThrowIfNoValue(obj, type);
			prop.name = [NSString stringWithFormat:@"%@Array", obj.name];
			prop.type = @"array";
			prop.isWildcardArrayValue = YES;
			
			FLArrayType* type = [FLArrayType arrayType];
			type.name = obj.name; //obj.name;
			type.typeName = [self fixTypeString:obj.type];
			[prop.arrayTypes addObject:type];
		}
		else if([self isEnum:obj]) {
//			FLThrowIfNoValue(obj, name);
			prop.name = obj.name;
			prop.type = @"string";
		}
		else if(FLStringIsNotEmpty(obj.ref)) {
			prop.name = obj.ref;
			prop.type = [self fixTypeString:obj.ref];
		}
		else {
			prop.name = obj.name;
			prop.type = [self fixTypeString:obj.type];
		}
	
		[bizObj.properties addObject:prop];
	
	}
}

- (void) createObjectFromComplexType:(FLWsdlComplexType*) complexType 
                                type:(NSString*) type {
	if(!type) {
		type = complexType.name;
	}
	
	FLConfirmStringIsNotEmpty_(type);

	if([complexType complexContentObject]) {
		if([complexType.complexContent extensionObject]) {
			FLObject* bizObj = [FLObject object];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.typeName = [self fixTypeString:type];
			bizObj.superclass = [FLSoapParser stringWithDeletedNamespacePrefix:complexType.complexContent.extension.base];
			FLConfirmStringIsNotEmpty_(bizObj.superclass);
			[self appendElementArrayAsProperties:bizObj elementArray:complexType.complexContent.extension.sequence];
			[_codeSchema.objects addObject:bizObj];
		}
		else if([complexType.complexContent restrictionObject]) {
			BOOL isArray = complexType.complexContent.restriction.sequenceObject &&
						[[[complexType.complexContent.restriction.sequence objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
		
			if(isArray) {
				FLArray* array = [FLArray array];
				array.name = type;
				   
				for(FLWsdlElement* obj in complexType.complexContent.restriction.sequence) {	  
					FLArrayType* newType = [FLArrayType arrayType];
					newType.name = obj.name;
					newType.typeName = [self fixTypeString:obj.type];
				
					[array.types addObject:newType];
				}
			
				[_codeSchema.arrays addObject:array];
			}

		}
	}
	else if([complexType sequenceObject]) {
		BOOL isArray = complexType.sequence.count == 1 && 
			[[[complexType.sequence objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
				
		if(isArray) {
			FLArray* array = [[FLArray alloc] init];
			array.name = type;
			   
			for(FLWsdlElement* obj in complexType.sequence) {	  
				FLArrayType* newType = [FLArrayType arrayType];
				newType.name = obj.name;
				newType.typeName = [self fixTypeString:obj.type];
			
				[array.types addObject:newType];
			}
		
			[_codeSchema.arrays addObject:array];
		}
		else {
			FLObject* bizObj = [FLObject object];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.typeName = [self fixTypeString:type];
			
			[self appendElementArrayAsProperties:bizObj elementArray:complexType.sequence];
			[_codeSchema.objects addObject:bizObj];
		}
	}
	else if([complexType choiceObject]) {
		FLArray* array = [FLArray array];
		array.name = type;
		   
		for(FLWsdlElement* obj in complexType.choice.elements) {	  
			FLArrayType* newType = [FLArrayType arrayType];
			newType.name = obj.name;
			newType.typeName = [self fixTypeString:obj.type];
		
			[array.types addObject:newType];
		}
	
		[_codeSchema.arrays addObject:array];
	}
	else {
// create empty object? 
		FLObject* bizObj = [FLObject object];
		bizObj.protocols = @"NSCoding, NSCopying";
		bizObj.typeName = [self fixTypeString:type];	
		[_codeSchema.objects addObject:bizObj];
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
	
	FLConfirmNotNil_(partType);

	return [self.project objectForTypeName:partType] != nil;
//    getObjectByType: type:partType] != nil;
}

#define ZEN 0

- (void) createMessageObject:(FLWsdlMessage*) msg
{
	if(msg.parts.count == 1) {	
		FLWsdlPart* part = [msg.parts objectAtIndex:0];
		if(FLStringIsNotEmpty(part.element)) {
			// this means we'll be using a different object here, and we don't need a message object.
			// this is for an input/output object

			// note that this if for wsdl:part that has elements, not type.
			
//			  <wsdl:message name="GetChallengeSoapIn">
//			  <wsdl:part name="parameters" element="tns:GetChallenge"/>
//			  </wsdl:message>
			
			return;
		}
	}

	FLObject* bizObj = [FLObject object];
	bizObj.protocols = @"NSCoding, NSCopying";
	bizObj.typeName = msg.name;
	
	for(FLWsdlPart* part in msg.parts) {
		FLProperty* prop = [FLProperty property];
		prop.name = part.name;
		
		if(FLStringIsNotEmpty(part.type)) {
			prop.type = [self fixTypeString:part.type];
		}
		else if(FLStringIsNotEmpty(part.element)) {
			prop.type = [self fixTypeString:part.element];
		}
		[bizObj.properties addObject:prop];
	}
	
	[_codeSchema.objects addObject:bizObj];
}



- (FLWsdlMessage*) getMessageObject:(NSString*) name  {
	name = [FLSoapParser stringWithDeletedNamespacePrefix:name];

	for(FLWsdlMessage* msg in self.wsdlDefinitions.messages) {
		if([msg.name isEqualToString:name]) {
			return msg;
		}
	}
	
	FLConfirmationFailure_v(@"Didn't find expected message object %@ (object referenced but not defined)", name);
	
	return nil;

}  

- (void) addPropertyForMessage:(FLObject*) bizObj
	isInput:(BOOL) isInput
	operation:(FLWsdlOperation*) operation 
	io:(FLWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames {
	FLWsdlMessage* msg = [self getMessageObject:io.message];	
	FLConfirmNotNil_(msg);
	
	FLProperty* ioOp = [FLProperty property];
	
	ioOp.type = msg.name;
	
	if(msg.parts.count) {
		FLWsdlPart* part = [msg.parts objectAtIndex:0];
		BOOL isElement = FLStringIsNotEmpty(part.element);
		if(isElement && msg.parts.count == 1) {
			// this means we'll be using a different object here, and we don't need a message object.
			// this is for an input/output object
			
			// note that this if for wsdl:part that has elements, not type.
			
			//			  <wsdl:message name="GetChallengeSoapIn">
			//			  <wsdl:part name="parameters" element="tns:GetChallenge"/>
			//			  </wsdl:message>
			
			ioOp.type = part.element;
		}


	} 
    
    ioOp.type = [self fixTypeString:ioOp.type];
	ioOp.name = isInput ? @"input" : @"output";
	[bizObj.properties addObject:ioOp];
}


- (void) propertyForMessage:(FLObject*) bizObj
	isInput:(BOOL) isInput
	operation:(FLWsdlOperation*) operation 
	io:(FLWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames {
			
	FLWsdlMessage* msg = [self getMessageObject:io.message];	
	FLConfirmNotNil_(msg);
	
	
	BOOL setProperties = NO;
	for(FLWsdlPart* part in msg.parts) {
		BOOL isElement = FLStringIsNotEmpty(part.element);
		
		if(!setProperties) {
			setProperties = YES;
			if(isInput) {
				FLProperty* opName = [FLProperty property];
				opName.type = @"string";
				opName.name = @"includeInputNamespaceAttribute";
				opName.isImmutable = [NSNumber numberWithBool:YES];
				opName.defaultValue = isElement ? @"YES" : @"NO";
				[bizObj.properties addObject:opName];
			

				FLProperty* xmlParameterName = [FLProperty property];
				xmlParameterName.isImmutable = [NSNumber numberWithBool:YES];
				xmlParameterName.type = @"string";
				xmlParameterName.name = @"operationParameterName";
				xmlParameterName.defaultValue = isElement ? operation.name : part.name;
				[bizObj.properties addObject:xmlParameterName];
			}
		}

		FLProperty* outProp = [FLProperty property];
		
		if(isElement) {
			outProp.type = part.element;
		}
		else  {
			NSString* type = [self fixTypeString:part.type];

FLAssertFailed_v(@"fixme");

FIXME("Not sure what this is doing, it's prob important tho")
//			if(FLStringIsNumber(type) || FLStringIsBool(type))
//			{
//				outProp.type = msg.name;
//			}
//			else
            {
				outProp.type = type;
			}
		}
		
		if(FLStringIsEmpty(outProp.type)) {
			outProp.type = @"string";
		}
	
		if(msg.parts.count == 1 && overrideInputOutputNames) {
			outProp.name = isInput ? @"input" : @"output";
		}
		else {
			outProp.name = part.name;
		}
		
		[bizObj.properties addObject:outProp];
	}
}

- (void) addOperationName:(FLObject*) object
	operation:(FLWsdlOperation*) operation 
	project:(FLCodeProject*) project {
	FLMethod* method = [FLMethod method];
	method.name = @"operationName";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.isStatic = [NSNumber numberWithBool:NO];
	method.returnType = @"NSString";
	method.code.lines = [NSString stringWithFormat:@"return @\"%@\";", operation.name];
	[object.methods addObject:method];
}

- (void) addContextInit:(FLObject*) object
             initValues:(NSMutableDictionary*) initValues {
    
    FLMethod* initMethod = [FLMethod method];
    initMethod.name = @"init";

    initMethod.isPrivate = [NSNumber numberWithBool:YES];
    initMethod.isStatic = [NSNumber numberWithBool:NO];
    initMethod.returnType = @"id";

    FLCodeBuilder* builder = [FLCodeBuilder codeBuilder];

    [builder appendLineWithFormat:@"if((self = [super init])) {"];
    [builder indent: ^{
        for(NSString* key in initValues) {
            [builder appendLineWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", [initValues objectForKey:key], key];
        }
    }];

    [builder appendLine:@"}"];
    [builder appendLine:@"return self;"];
    
    initMethod.code.lines = builder.string;
    
    [object.methods addObject:initMethod];
}

- (void) createNewOperationObject:(FLWsdlOperation*) operation 
                         portName:(NSString*) portName
                          project:(FLCodeProject*) project {
	
    FLObject* bizObj = [FLObject object];
	bizObj.typeName = [NSString stringWithFormat:@"%@%@", portName, operation.name];
	bizObj.superclass = @"FLHttpOperation";
	bizObj.comment = operation.documentation;
	bizObj.canLazyCreateValue = YES;
	
	[_operations addObject:bizObj];
	
	// add operation name property
//	FLProperty* opName = [[FLProperty property] autorelease];
//	  opName.name = @"operationName";
//	  opName.type = @"string";
//	  opName.defaultValue = operation.name;
//	opName.isImmutable = [NSNumber numberWithBool:YES];
//	  opName.isPrivate = [NSNumber numberWithBool:YES];
//	[bizObj.properties addObject:opName];
	
//	[self addBehaviorInitializer:bizObj operation:operation project:project]; 
	[self addOperationName:bizObj operation:operation project:project]; 
	
    [self addPropertyForMessage:bizObj 
                        isInput:YES 
                      operation:operation 
                             io:operation.input 
       overrideInputOutputNames:NO];

    [self addPropertyForMessage:bizObj 
                        isInput:NO 
                      operation:operation 
                             io:operation.output
       overrideInputOutputNames:NO];

	


	[_codeSchema.objects addObject:bizObj];
}

- (FLProperty*) createBindingOperationObject:(FLWsdlOperation*) operation {
	FLProperty* prop = [FLProperty property];
	prop.name = operation.name;
	prop.type = @"string";
	prop.isImmutableValue = YES;
	
	if(operation.operationObject) {
		FLWsdlOperation* childOperation = operation.operation;
	
		if(FLStringIsNotEmpty(childOperation.soapAction)) {
			prop.defaultValue = childOperation.soapAction;
		}
		else if(FLStringIsNotEmpty(childOperation.location)) {
			prop.defaultValue = childOperation.location;
		}
	}
	
	
	return prop;
}

- (NSString*) getServicePortLocationFromBinding:(FLWsdlBinding*) binding {
	FLConfirmStringIsNotEmpty_(binding.name);
	
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
	for(FLWsdlPortType* port in _definitions.service.ports) {
		if([port.binding isEqualToString:binding.type]) {
			return port.address.location;
		}
	}
	
    FLThrowErrorCode_v(FLCodeGeneratorErrorDomain, FLErrorTranslatorFailed, @"Service location string not found in service %@", _definitions.service.name);
	return nil;
}

- (void) createServiceManager:(FLWsdlBinding*) binding {
	FLObject* bizObj = [FLObject object];
	bizObj.typeName = binding.name;
	bizObj.superclass =	 @"FLNetworkServerContext";
	bizObj.isSingleton = [NSNumber numberWithBool:YES];

	
	NSString* url = [self getServicePortLocationFromBinding:binding];
	FLConfirmStringIsNotEmpty_(url);
	
	FLProperty* urlProp = [FLProperty property];
	urlProp.name = @"url";
	urlProp.type = @"string";		
	urlProp.defaultValue = url;		   
	urlProp.isImmutable = [NSNumber numberWithBool:YES];
					
	
	FLProperty* targetNamespace = [FLProperty property];
	targetNamespace.name = @"targetNamespace";	
	targetNamespace.type = @"string";	
			
	if(FLStringIsNotEmpty(_definitions.targetNamespace)) {
		targetNamespace.defaultValue = _definitions.targetNamespace;
		targetNamespace.isImmutable = [NSNumber numberWithBool:YES];
	}
			
	NSMutableDictionary* initValues = [NSMutableDictionary dictionary];
	[initValues setObject:url forKey:FLNetworkServerPropertyKeyUrl];
	[initValues setObject:_definitions.targetNamespace forKey:FLNetworkServerPropertyKeyTargetNamespace];

	for(FLWsdlOperation* op in binding.operations) {
		FLProperty* prop = 
			[self createBindingOperationObject:(FLWsdlOperation*) op];
		[initValues setObject:prop.defaultValue forKey:prop.name];
	}

	for(NSString* key in initValues) {
		NSString* value = [initValues objectForKey:key];
	
        NSString* line = [NSString stringWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", value, key];
		[ ((NSMutableArray*)bizObj.linesForInitMethod) addObject:line];
	}

	
	[_codeSchema.objects addObject:bizObj];
}

- (FLProperty*) propForName:(FLObject*) obj name:(NSString*) name {
//	FLProperty* input = 

	for(FLProperty* prop in obj.properties) {
		if(FLStringsAreEqual(prop.name, name)) {
			return prop;
		}
	}

	return nil;
} 


- (void) prepareObjects {
	for(FLObject* obj in self.project.objects) {
		for(FLProperty* prop in obj.properties) {
			prop.type = [self fixTypeString:prop.type];
		}
	}
}

- (void) createObjectFromSimpleType:(FLWsdlSimpleType*) simpleType
	optionalName:(NSString*) optionalName {
	
    if([simpleType restrictionObject]) {
		FLEnumType* enumType = [FLEnumType enumType];

		enumType.typeName = optionalName ? optionalName : simpleType.name;

		for(FLWsdlEnumeration* wsdlEnum in simpleType.restriction.enumerations) {
		
			FLEnum* newEnum = [FLEnum enum];
			newEnum.name = wsdlEnum.value;
			
			[enumType.enums addObject:newEnum];
			
		}
		
		[_codeSchema.enumTypes addObject:enumType];
	}
	
	if([simpleType listObject]) {
		[self createObjectFromSimpleType:simpleType.list.simpleType optionalName:simpleType.name];
	}
}

- (void) createObjectFromElement:(FLWsdlElement*) element
{
	if([element complexTypeObject]) {
		[self createObjectFromComplexType:element.complexType type:element.name];
	}
	else {
		[_output appendLineWithFormat:@"Skipping element with no complexType content: %@", [[element description] trimmedStringWithNoLFCR]];
	}
}


- (FLWsdlDefinitions*) _parseWsdl:(NSData*) xml 
{
	FLSoapParser* parser = [FLSoapParser soapParser:xml];
	FLWsdlDefinitions* defs = [FLWsdlDefinitions wsdlDefinitions];
	[parser buildObjects:defs];
	return defs;
}

- (void) buildCodeGeneratorSchema:(NSString*) fromFilePath 
/*	project:(FLCodeProject*) project */
	project:(FLCodeProject*) project
{
//	NSData* xml = [NSData dataWithContentsOfURL:[NSURL URLWithString:project.fileUrl]];
//
//	FLWsdlDefinitions* definitions = [FLWsdlCodeProjectReader parseWsdl:xml];
//
//	[self buildCodeGeneratorSchemaFromWsdlDefinitions:definitions project:project];
//	
//	NSString* intermediatePath = [NSString stringWithFormat:@"%@.cgwsdl", [[project parentProjectPath] stringByDeletingLastPathComponent], project.schemaName];
//	
//	FLXmlBuilder* xmlBuilder = [FLXmlBuilder xmlBuilder];
//	[xmlBuilder addVersionAndEncodingHeader];
//	[xmlBuilder openElement:@"schema"];
//
//#if NEW_BUILDER
//	[xmlBuilder addObjectAsXML:project];
//#else
//	[xmlBuilder streamObject:project];
//#endif
//	[xmlBuilder closeElement];
//	
//	[xmlBuilder.string writeToFile:intermediatePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}




@end

#endif
