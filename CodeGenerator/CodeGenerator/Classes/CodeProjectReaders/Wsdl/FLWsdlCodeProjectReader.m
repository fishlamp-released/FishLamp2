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

//BOOL FLCreatePropertyIfNil(id object, NSString* propertyName) {
//    
//    if([object valueForKey:propertyName] == nil) {
//        Class aClass = [[object propertyClassForName:propertyName];
//        if(aClass) {
//            id object = FLAutorelease([[aClass alloc] init]);
//            if(object) {
//                [object setValue:object forKey:propertyName];
//                return YES;
//            }   
//        }
//        
//    }
//
//    return NO;
//}

@implementation FLCodeProject (Wsdl)

- (id) objectForTypeName:(NSString*) name {
    FLAssertFailed();
    return nil;
}

@end

NSString* DeleteNamespacePrefix(NSString* string) {
    NSRange range = [string rangeOfString:@":"];
    if(range.length) {
        return [string substringFromIndex:range.location + 1];
    }
    return string;
} 

@interface FLWsdlCodeProjectReader ()
@property (readwrite, assign, nonatomic) FLCodeProject* project;
@property (readwrite, strong, nonatomic) FLWsdlDefinitions* wsdlDefinitions;
//@property (readwrite, strong, nonatomic) FLCodeBuilder* output;
@end

@implementation FLWsdlCodeProjectReader

@synthesize project = _project;
@synthesize wsdlDefinitions = _wsdlDefinitions;
//@synthesize output = _output;

- (id) init {
	if((self = [super init])) {
//		_operations = [[NSMutableArray alloc] init];
	}
	return self;
}

#if FL_DEALLOC
- (void) dealloc {	
//	[_operations release];
	[_project release];
	[_wsdlDefinitions release];
//	[_output release];
	[super dealloc];
}
#endif

- (NSString*) fixTypeString:(NSString*) wsdlType {
    wsdlType = DeleteNamespacePrefix(wsdlType);
	return wsdlType;
}

- (BOOL) isEnum:(FLWsdlElement*) element {
	FLConfirmNotNil(element);

	for(FLCodeEnumType* anEnum in self.project.enumTypes) {
		if([anEnum.typeName isEqualToString:element.type]) {
			return YES;
		}
	}
	
	return NO;
}

- (void) appendElementArrayAsProperties:(FLCodeObject*) bizObj elementArray:(NSArray*) elementArray
{
	for(FLWsdlElement* obj in elementArray) {
		FLCodeProperty* prop = [FLCodeProperty property];
		if([obj.maxOccurs isEqualToString:@"unbounded"]) {
		//	FLThrowIfNoValue(obj, type);
			prop.name = [NSString stringWithFormat:@"%@Array", obj.name];
			prop.type = @"array";
			
			FLCodeArrayType* type = [FLCodeArrayType arrayType];
			type.name = obj.name; //obj.name;
			type.typeName = DeleteNamespacePrefix(obj.type);
			[prop.arrayTypes addObject:type];
		}
		else if([self isEnum:obj]) {
//			FLThrowIfNoValue(obj, name);
			prop.name = obj.name;
			prop.type = @"string";
		}
		else if(FLStringIsNotEmpty(obj.ref)) {
			prop.name = obj.ref;
			prop.type = DeleteNamespacePrefix(obj.ref);
		}
		else {
			prop.name = obj.name;
			prop.type = DeleteNamespacePrefix(obj.type);
		}
	
		[bizObj.properties addObject:prop];
	
	}
}

- (void) createObjectFromComplexType:(FLWsdlComplexType*) complexType 
                                type:(NSString*) type {
	if(!type) {
		type = complexType.name;
	}
	
	FLConfirmStringIsNotEmpty(type);

	if([complexType complexContent]) {
		if([complexType.complexContent extension]) {
			FLCodeObject* bizObj = [FLCodeObject object];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.className = DeleteNamespacePrefix(type);
			bizObj.superclass = DeleteNamespacePrefix(complexType.complexContent.extension.base);
            
			FLConfirmStringIsNotEmpty(bizObj.superclass);
			
            [self appendElementArrayAsProperties:bizObj elementArray:complexType.complexContent.extension.sequences];
			
            [self.project.objects addObject:bizObj];
		}
		else if([complexType.complexContent restriction]) {
			BOOL isArray = complexType.complexContent.restriction.sequences &&
						[[[complexType.complexContent.restriction.sequences objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
		
			if(isArray) {
				FLCodeArray* array = [FLCodeArray array];
				array.name = type;
				   
				for(FLWsdlElement* obj in complexType.complexContent.restriction.sequences) {	  
					FLCodeArrayType* newType = [FLCodeArrayType arrayType];
					newType.name = obj.name;
					newType.typeName = DeleteNamespacePrefix(obj.type);
				
					[array.types addObject:newType];
				}
			
				[self.project.arrays addObject:array];
			}

		}
	}
	else if([complexType sequences]) {
		BOOL isArray = complexType.sequences.count == 1 && 
			[[[complexType.sequences objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
				
		if(isArray) {
			FLCodeArray* array = [[FLCodeArray alloc] init];
			array.name = type;
			   
			for(FLWsdlElement* obj in complexType.sequences) {	  
				FLCodeArrayType* newType = [FLCodeArrayType arrayType];
				newType.name = obj.name;
				newType.typeName = DeleteNamespacePrefix(obj.type);
			
				[array.types addObject:newType];
			}
		
			[self.project.arrays addObject:array];
		}
		else {
			FLCodeObject* bizObj = [FLCodeObject object];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.className = DeleteNamespacePrefix(type);
			
			[self appendElementArrayAsProperties:bizObj elementArray:complexType.sequences];
			[self.project.objects addObject:bizObj];
		}
	}
	else if([complexType choice]) {
		FLCodeArray* array = [FLCodeArray array];
		array.name = type;
		   
		for(FLWsdlElement* obj in complexType.choice.elements) {	  
			FLCodeArrayType* newType = [FLCodeArrayType arrayType];
			newType.name = obj.name;
			newType.typeName = DeleteNamespacePrefix(obj.type);
		
			[array.types addObject:newType];
		}
	
		[self.project.arrays addObject:array];
	}
	else {
// create empty object? 
		FLCodeObject* bizObj = [FLCodeObject object];
		bizObj.protocols = @"NSCoding, NSCopying";
		bizObj.className = DeleteNamespacePrefix(type);	
		[self.project.objects addObject:bizObj];
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

	FLCodeObject* bizObj = [FLCodeObject object];
	bizObj.protocols = @"NSCoding, NSCopying";
	bizObj.className = msg.name;
	
	for(FLWsdlPart* part in msg.parts) {
		FLCodeProperty* prop = [FLCodeProperty property];
		prop.name = part.name;
		
		if(FLStringIsNotEmpty(part.type)) {
			prop.type = DeleteNamespacePrefix(part.type);
		}
		else if(FLStringIsNotEmpty(part.element)) {
			prop.type = DeleteNamespacePrefix(part.element);
		}
		[bizObj.properties addObject:prop];
	}
	
	[self.project.objects addObject:bizObj];
}



- (FLWsdlMessage*) getMessageObject:(NSString*) name  {
	name = DeleteNamespacePrefix(name);

	for(FLWsdlMessage* msg in self.wsdlDefinitions.messages) {
		if([msg.name isEqualToString:name]) {
			return msg;
		}
	}
	
	FLConfirmationFailureWithComment(@"Didn't find expected message object %@ (object referenced but not defined)", name);
	
	return nil;

}  

- (void) addPropertyForMessage:(FLCodeObject*) bizObj
	isInput:(BOOL) isInput
	operation:(FLWsdlOperation*) operation 
	io:(FLWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames {
	FLWsdlMessage* msg = [self getMessageObject:io.message];	
	FLConfirmNotNil(msg);
	
	FLCodeProperty* ioOp = [FLCodeProperty property];
	
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
    
    ioOp.type = DeleteNamespacePrefix(ioOp.type);
	ioOp.name = isInput ? @"input" : @"output";
	[bizObj.properties addObject:ioOp];
}


- (void) propertyForMessage:(FLCodeObject*) bizObj
	isInput:(BOOL) isInput
	operation:(FLWsdlOperation*) operation 
	io:(FLWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames {
			
	FLWsdlMessage* msg = [self getMessageObject:io.message];	
	FLConfirmNotNil(msg);
	
	
	BOOL setProperties = NO;
	for(FLWsdlPart* part in msg.parts) {
		BOOL isElement = FLStringIsNotEmpty(part.element);
		
		if(!setProperties) {
			setProperties = YES;
			if(isInput) {
				FLCodeProperty* opName = [FLCodeProperty property];
				opName.type = @"string";
				opName.name = @"includeInputNamespaceAttribute";
				opName.isImmutable = [NSNumber numberWithBool:YES];
				opName.defaultValue = isElement ? @"YES" : @"NO";
				[bizObj.properties addObject:opName];
			

				FLCodeProperty* xmlParameterName = [FLCodeProperty property];
				xmlParameterName.isImmutable = [NSNumber numberWithBool:YES];
				xmlParameterName.type = @"string";
				xmlParameterName.name = @"operationParameterName";
				xmlParameterName.defaultValue = isElement ? operation.name : part.name;
				[bizObj.properties addObject:xmlParameterName];
			}
		}

		FLCodeProperty* outProp = [FLCodeProperty property];
		
		if(isElement) {
			outProp.type = part.element;
		}
		else  {
			NSString* type = DeleteNamespacePrefix(part.type);

FLAssertFailedWithComment(@"fixme");

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

- (void) addOperationName:(FLCodeObject*) object
	operation:(FLWsdlOperation*) operation 
	project:(FLCodeProject*) project {
	FLCodeMethod* method = [FLCodeMethod method];
	method.name = @"operationName";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.isStatic = [NSNumber numberWithBool:NO];
	method.returnType = @"NSString";
	method.code.lines = [NSString stringWithFormat:@"return @\"%@\";", operation.name];
	[object.methods addObject:method];
}

- (void) addContextInit:(FLCodeObject*) object
             initValues:(NSMutableDictionary*) initValues {
    
    FLCodeMethod* initMethod = [FLCodeMethod method];
    initMethod.name = @"init";

    initMethod.isPrivate = [NSNumber numberWithBool:YES];
    initMethod.isStatic = [NSNumber numberWithBool:NO];
    initMethod.returnType = @"id";

    FLPrettyString* builder = [FLPrettyString prettyString];

    [builder appendLineWithFormat:@"if((self = [super init])) {"];
    [builder indent: ^{
        for(NSString* key in initValues) {
            [builder appendLineWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", [initValues objectForKey:key], key];
        }
    }];

    [builder appendLine:@"}"];
    [builder appendLine:@"return self;"];
    
    initMethod.code.lines = [builder string];
    
    [object.methods addObject:initMethod];
}

- (void) createNewOperationObject:(FLWsdlOperation*) operation 
                         portName:(NSString*) portName
                          project:(FLCodeProject*) project {
	
    FLCodeObject* bizObj = [FLCodeObject object];
	bizObj.className = [NSString stringWithFormat:@"%@%@", portName, operation.name];
	bizObj.superclass = @"FLHttpOperation";
	bizObj.comment = operation.documentation;
	
//	[_operations addObject:bizObj];
	
	// add operation name property
//	FLCodeProperty* opName = [[FLCodeProperty property] autorelease];
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

	


	[self.project.objects addObject:bizObj];
}

- (FLCodeProperty*) createBindingOperationObject:(FLWsdlOperation*) operation {
	FLCodeProperty* prop = [FLCodeProperty property];
	prop.name = operation.name;
	prop.type = @"string";
	prop.isImmutable = YES;
	
	if(operation.operation) {
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

- (void) createServiceManager:(FLWsdlBinding*) binding {
	FLCodeObject* bizObj = [FLCodeObject object];
	bizObj.className = binding.name;
	bizObj.superclass =	 @"FLNetworkServerContext";
	bizObj.isSingleton = [NSNumber numberWithBool:YES];

	
	NSString* url = [self getServicePortLocationFromBinding:binding];
	FLConfirmStringIsNotEmpty(url);
	
	FLCodeProperty* urlProp = [FLCodeProperty property];
	urlProp.name = @"url";
	urlProp.type = @"string";		
	urlProp.defaultValue = url;		   
	urlProp.isImmutable = [NSNumber numberWithBool:YES];
					
	
	FLCodeProperty* targetNamespace = [FLCodeProperty property];
	targetNamespace.name = @"targetNamespace";	
	targetNamespace.type = @"string";	
			
	if(FLStringIsNotEmpty(self.wsdlDefinitions.targetNamespace)) {
		targetNamespace.defaultValue = self.wsdlDefinitions.targetNamespace;
		targetNamespace.isImmutable = [NSNumber numberWithBool:YES];
	}
			
	NSMutableDictionary* initValues = [NSMutableDictionary dictionary];
	[initValues setObject:url forKey:FLNetworkServerPropertyKeyUrl];
	[initValues setObject:self.wsdlDefinitions.targetNamespace forKey:FLNetworkServerPropertyKeyTargetNamespace];

	for(FLWsdlOperation* op in binding.operations) {
		FLCodeProperty* prop = 
			[self createBindingOperationObject:(FLWsdlOperation*) op];
		[initValues setObject:prop.defaultValue forKey:prop.name];
	}

	for(NSString* key in initValues) {
		NSString* value = [initValues objectForKey:key];
	
        NSString* line = [NSString stringWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", value, key];
		[ ((NSMutableArray*)bizObj.linesForInitMethod) addObject:line];
	}

	
	[self.project.objects addObject:bizObj];
}

- (FLCodeProperty*) propForName:(FLCodeObject*) obj name:(NSString*) name {
//	FLCodeProperty* input = 

	for(FLCodeProperty* prop in obj.properties) {
		if(FLStringsAreEqual(prop.name, name)) {
			return prop;
		}
	}

	return nil;
} 


- (void) prepareObjects {
	for(FLCodeObject* obj in self.project.objects) {
		for(FLCodeProperty* prop in obj.properties) {
			prop.type = DeleteNamespacePrefix(prop.type);
		}
	}
}

- (void) createObjectFromSimpleType:(FLWsdlSimpleType*) simpleType
	optionalName:(NSString*) optionalName {
	
    if([simpleType restriction]) {
		FLCodeEnumType* enumType = [FLCodeEnumType enumType];

		enumType.typeName = optionalName ? optionalName : simpleType.name;

		for(FLWsdlEnumeration* wsdlEnum in simpleType.restriction.enumerations) {
		
			FLCodeEnum* newEnum = [FLCodeEnum codeEnum];
			newEnum.name = wsdlEnum.value;
			
			[enumType.enums addObject:newEnum];
			
		}
		
		[self.project.enumTypes addObject:enumType];
	}
	
	if([simpleType list]) {
		[self createObjectFromSimpleType:simpleType.list.simpleType optionalName:simpleType.name];
	}
}

- (void) createObjectFromElement:(FLWsdlElement*) element
{
	if([element complexType]) {
		[self createObjectFromComplexType:element.complexType type:element.name];
	}
	else {
//		[_output appendLineWithFormat:@"Skipping element with no complexType content: %@", [[element description] trimmedStringWithNoLFCR]];
	}
}

+ (FLWsdlCodeProjectReader*) wsdlCodeReader {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location {
    return [location isLocationType:FLCodeProjectLocationTypeWsdl];
}

- (FLCodeProject *)readProjectFromLocation:(FLCodeProjectLocation *)descriptor {

	NSData* xml = [descriptor loadDataInResource];

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:xml];

    self.wsdlDefinitions = [FLWsdlDefinitions objectWithXmlElement:parsedSoap withObjectBuilder:[FLSoapObjectBuilder instance]];
	
    self.project = [FLCodeProject project];

// TODO: abstract away objc

	FLCodeTypeDefinition* define1 = [FLCodeTypeDefinition typeDefinition];
	define1.typeName = @"FLNetworkServerContext";
	define1.import = @"FLNetworkServerContext.h";
	[self.project.typeDefinitions addObject:define1];

	FLCodeTypeDefinition* define2 = [FLCodeTypeDefinition typeDefinition];
	define2.typeName = @"FLHttpOperation";
	define2.import = @"FLHttpOperation.h";
	[self.project.typeDefinitions addObject:define2];

//	FLTypeDefinition* define3 = [FLTypeDefinition TypeDefinition];
//	define3.typeName = @"FLNetworkEndpointHelper";
//	define3.import @"FLNetworkEndpointHelper.h";
//	[project.typeDefinitions addObject:define3];

	if(FLStringIsNotEmpty(self.wsdlDefinitions.documentation)) {
		self.project.comment = self.wsdlDefinitions.documentation;
	}
	
	for(FLWsdlSchema* schema in self.wsdlDefinitions.types) {
		for(FLWsdlSimpleType* simpleType in schema.simpleTypes) {
			[self createObjectFromSimpleType:simpleType optionalName:nil];
		}
		for(FLWsdlComplexType* complexType in schema.complexTypes) {
			[self createObjectFromComplexType:complexType type:nil];
		}
		for(FLWsdlElement* element in schema.elements) {
			[self createObjectFromElement:element];
		}
	}
	for(FLWsdlMessage* message in self.wsdlDefinitions.messages) {
		[self createMessageObject:message];
	}
	for(FLWsdlBinding* binding in self.wsdlDefinitions.bindings) {
		[self createServiceManager:binding];  
	}
	for(FLWsdlPortType* portType in self.wsdlDefinitions.portTypes) {
		for(FLWsdlOperation* operation in portType.operations) {
			[self createNewOperationObject:operation portName:portType.name project:self.project];
		}
	}
	
	[self prepareObjects];
    
    return self.project;

}




@end

