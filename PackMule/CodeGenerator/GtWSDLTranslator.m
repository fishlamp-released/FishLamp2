//
//	GtWsdlCodeGenerator.m
//	PackMule
//
//	Created by Mike Fullerton on 8/9/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWsdlTranslator.h"
#import "GtCodeGenerator.h"
#import "GtSoapParser.h"
#import "GtStringUtilities.h"
#import "GtXmlBuilder.h"
#import "GtDataTypeIDUtilities.h"
#import "GtNetworkServerContext.h"
#import "NSObject+XML.h"

@implementation GtWsdlTranslator

@synthesize codeSchema = m_codeSchema;
@synthesize wsdlDefinitions = m_definitions;
@synthesize output = m_output;

- (id) init
{
	if((self = [super init]))
	{
		m_operations = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) dealloc
{	
	[m_operations release];
	[m_codeSchema release];
	[m_definitions release];
	[m_output release];
	[super dealloc];
}


#define CodeGenFail @"GtWsdl code generator failed"

- (NSString*) fixTypeString:(NSString*) wsdlType
{
	wsdlType = [GtSoapParser stringWithDeletedNamespacePrefix:wsdlType];
	return wsdlType;
}

- (BOOL) isEnum:(GtWsdlElement*) element
{
	GtThrowIfNil(element);

	for(GtCodeGeneratorEnumType* anEnum in self.codeSchema.enumTypes)
	{
		if([anEnum.typeName isEqualToString:element.type])
		{
			return YES;
		}
	}
	
	return NO;
}

- (void) addElementArrayAsProperties:(GtCodeGeneratorObject*) bizObj elementArray:(NSArray*) elementArray
{
	for(GtWsdlElement* obj in elementArray)
	{
		GtCodeGeneratorProperty* prop = [GtCodeGeneratorProperty codeGeneratorProperty];
		if([obj.maxOccurs isEqualToString:@"unbounded"])
		{
		//	GtThrowIfNoValue(obj, type);
			prop.name = [NSString stringWithFormat:@"%@Array", obj.name];
			prop.type = @"array";
			prop.isWildcardArrayValue = YES;
			
			GtCodeGeneratorArrayType* type = [GtCodeGeneratorArrayType codeGeneratorArrayType];
			type.name = obj.name; //obj.name;
			type.typeName = [self fixTypeString:obj.type];
			[prop.arrayTypes addObject:type];
		}
		else if([self isEnum:obj])
		{
//			GtThrowIfNoValue(obj, name);
			prop.name = obj.name;
			prop.type = @"string";
		}
		else if(GtStringIsNotEmpty(obj.ref))
		{
			prop.name = obj.ref;
			prop.type = [self fixTypeString:obj.ref];
		}
		else
		{
			prop.name = obj.name;
			prop.type = [self fixTypeString:obj.type];
		}
	
		[bizObj.properties addObject:prop];
	
	}
}

- (void) createObjectFromComplexType: (GtWsdlComplexType*) complexType 
	type:(NSString*) type
{
	if(!type)
	{
		type = complexType.name;
	}
	
	GtThrowIfStringEmpty(type);

	if([complexType complexContentObject])
	{
		if([complexType.complexContent extensionObject])
		{
			GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.typeName = [self fixTypeString:type];
			bizObj.superclass = [GtSoapParser stringWithDeletedNamespacePrefix:complexType.complexContent.extension.base];
			GtAssertIsValidString(bizObj.superclass);
			[self addElementArrayAsProperties:bizObj elementArray:complexType.complexContent.extension.sequence];
			[m_codeSchema.objects addObject:bizObj];
			[bizObj release];
		}
		else if([complexType.complexContent restrictionObject])
		{
			BOOL isArray = complexType.complexContent.restriction.sequenceObject &&
						[[[complexType.complexContent.restriction.sequence objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
		
			if(isArray)
			{
				GtCodeGeneratorArray* array = [[GtCodeGeneratorArray alloc] init];
				array.name = type;
				   
				for(GtWsdlElement* obj in complexType.complexContent.restriction.sequence)
				{	  
					GtCodeGeneratorArrayType* type = [[GtCodeGeneratorArrayType alloc] init];
					type.name = obj.name;
					type.typeName = [self fixTypeString:obj.type];
				
					[array.types addObject:type];
					[type release];
				}
			
				[m_codeSchema.arrays addObject:array];
				[array release];
			}
			/*
			else
			
			GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
			
			[m_codeSchema.objects addObject:bizObj];
			[bizObj release];
			*/
		}
	}
	else if([complexType sequenceObject])
	{
		BOOL isArray = complexType.sequence.count == 1 && 
			[[[complexType.sequence objectAtIndex:0] maxOccurs] isEqualToString:@"unbounded"];
				
		if(isArray)
		{
			GtCodeGeneratorArray* array = [[GtCodeGeneratorArray alloc] init];
			array.name = type;
			   
			for(GtWsdlElement* obj in complexType.sequence)
			{	  
				GtCodeGeneratorArrayType* type = [[GtCodeGeneratorArrayType alloc] init];
				type.name = obj.name;
				type.typeName = [self fixTypeString:obj.type];
			
				[array.types addObject:type];
				[type release];
			}
		
			[m_codeSchema.arrays addObject:array];
			[array release];
		}
		else
		{
			GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
			bizObj.protocols = @"NSCoding, NSCopying";
			bizObj.typeName = [self fixTypeString:type];
			
			[self addElementArrayAsProperties:bizObj elementArray:complexType.sequence];
			[m_codeSchema.objects addObject:bizObj];
			[bizObj release];
		}
	}
	else if([complexType choiceObject])
	{
		GtCodeGeneratorArray* array = [[GtCodeGeneratorArray alloc] init];
		array.name = type;
		   
		for(GtWsdlElement* obj in complexType.choice.elements)
		{	  
			GtCodeGeneratorArrayType* type = [[GtCodeGeneratorArrayType alloc] init];
			type.name = obj.name;
			type.typeName = [self fixTypeString:obj.type];
		
			[array.types addObject:type];
			[type release];
		}
	
		[m_codeSchema.arrays addObject:array];
		[array release];
	}
	else
	{
// create empty object? 
		GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
		bizObj.protocols = @"NSCoding, NSCopying";
		bizObj.typeName = [self fixTypeString:type];	
		[m_codeSchema.objects addObject:bizObj];
		[bizObj release];
	}
}

- (BOOL) partTypeIsObject:(GtWsdlPart*) part
{
	NSString* partType = nil;
	if(GtStringIsNotEmpty(part.type))
	{
		partType = part.type;
	}
	else if(GtStringIsNotEmpty(part.element))
	{
		partType = part.element;
	}
	
	GtThrowIfNil(partType);

	return [GtCodeGenerator getObjectByType:self.codeSchema type:partType] != nil;
}

#define ZEN 0

- (void) createMessageObject:(GtWsdlMessage*) msg
{
	if(msg.parts.count == 1)
	{	
		GtWsdlPart* part = [msg.parts objectAtIndex:0];
		if(GtStringIsNotEmpty(part.element))
		{
			// this means we'll be using a different object here, and we don't need a message object.
			// this is for an input/output object

			// note that this if for wsdl:part that has elements, not type.
			
//			  <wsdl:message name="GetChallengeSoapIn">
//			  <wsdl:part name="parameters" element="tns:GetChallenge"/>
//			  </wsdl:message>
			
			return;
		}
	}

	GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
	bizObj.protocols = @"NSCoding, NSCopying";
	bizObj.typeName = msg.name;
	
	for(GtWsdlPart* part in msg.parts)
	{
		GtCodeGeneratorProperty* prop = [[[GtCodeGeneratorProperty alloc] init] autorelease];
		prop.name = part.name;
		
		if(GtStringIsNotEmpty(part.type))
		{
			prop.type = [self fixTypeString:part.type];
		}
		else if(GtStringIsNotEmpty(part.element))
		{
			prop.type = [self fixTypeString:part.element];
		}
		[bizObj.properties addObject:prop];
	}
	
	[m_codeSchema.objects addObject:bizObj];
	[bizObj release];
}



- (GtWsdlMessage*) getMessageObject:(NSString*) name 
{
	name = [GtSoapParser stringWithDeletedNamespacePrefix:name];

	for(GtWsdlMessage* msg in self.wsdlDefinitions.messages)
	{
		if([msg.name isEqualToString:name])
		{
			return msg;
		}
	}
	
	GtAssertFailed(@"Didn't find expected message object %@ (object referenced but not defined)", name);
	
	return nil;

}

//- (void) _setInputIsLazyCreated:(GtWsdlInputOutput*) input
//                     codeSchema:(GtCodeGeneratorProject*) codeSchema
//{
//    NSString* name = [self fixTypeString:input.type]
//    
//    for(GtCodeGenerator* object in codeSchema.objects)
//    {
//        if(GtStringsAreEqual(object.name, name))
//        {
//            object.canLazyCreateValue = YES;
//            break;
//        }
//        
//    }
//    
//}    

- (GtCodeGeneratorProperty*) newPropertyForMessage:(GtCodeGeneratorObject*) bizObj
	isInput:(BOOL) isInput
	operation:(GtWsdlOperation*) operation 
	io:(GtWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames
{
	GtWsdlMessage* msg = [self getMessageObject:io.message];	
	GtThrowIfNil(msg);
	
	GtCodeGeneratorProperty* ioOp = [[[GtCodeGeneratorProperty alloc] init] autorelease];
	
	ioOp.type = msg.name;
	
	if(msg.parts.count)
	{
		GtWsdlPart* part = [msg.parts objectAtIndex:0];
		BOOL isElement = GtStringIsNotEmpty(part.element);
		if(isElement && msg.parts.count == 1)
		{
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
	
	return ioOp;
	

}


- (void) propertyForMessage:(GtCodeGeneratorObject*) bizObj
	isInput:(BOOL) isInput
	operation:(GtWsdlOperation*) operation 
	io:(GtWsdlInputOutput*) io
	overrideInputOutputNames:(BOOL) overrideInputOutputNames
{
			
	GtWsdlMessage* msg = [self getMessageObject:io.message];	
	GtThrowIfNil(msg);
	
	
	BOOL setProperties = NO;
	BOOL isParametersObject = NO;
	for(GtWsdlPart* part in msg.parts)
	{
		BOOL isElement = GtStringIsNotEmpty(part.element);
		
		if(!setProperties)
		{
			setProperties = YES;
			if(isInput)
			{
				GtCodeGeneratorProperty* opName = [[[GtCodeGeneratorProperty alloc] init] autorelease];
				opName.type = @"string";
				opName.name = @"includeInputNamespaceAttribute";
				opName.isImmutable = [NSNumber numberWithBool:YES];
				opName.defaultValue = isElement ? @"YES" : @"NO";
				[bizObj.properties addObject:opName];
			

				GtCodeGeneratorProperty* xmlParameterName = [[[GtCodeGeneratorProperty alloc] init] autorelease];
				xmlParameterName.isImmutable = [NSNumber numberWithBool:YES];
				xmlParameterName.type = @"string";
				xmlParameterName.name = @"operationParameterName";
				xmlParameterName.defaultValue = isElement ? operation.name : part.name;
				[bizObj.properties addObject:xmlParameterName];
			}
		}

		GtCodeGeneratorProperty* outProp = [[[GtCodeGeneratorProperty alloc] init] autorelease];
		isParametersObject = YES;
		
		if(isElement)
		{
			outProp.type = part.element;
		}
		else 
		{
			NSString* type = [self fixTypeString:part.type];
			if(GtStringIsNumber(type) || GtStringIsBool(type))
			{
				outProp.type = msg.name;
			}
			else
			{
				outProp.type = type;
			}
		}
		
		if(GtStringIsEmpty(outProp.type))
		{
			outProp.type = @"string";
		}
	
		if(msg.parts.count == 1 && overrideInputOutputNames)
		{
			outProp.name = isInput ? @"input" : @"output";
		}
		else
		{
			outProp.name = part.name;
		}
		
		[bizObj.properties addObject:outProp];
	}
}

- (void) addOperationName:(GtCodeGeneratorObject*) object
	operation:(GtWsdlOperation*) operation 
	codeSchema:(GtCodeGeneratorProject*) codeSchema
{
	GtCodeGeneratorMethod* method = [[GtCodeGeneratorMethod alloc] init];
	method.name = @"operationName";
	method.isPrivate = [NSNumber numberWithBool:YES];
	method.isStatic = [NSNumber numberWithBool:NO];
	method.returnType = @"NSString";
	method.code.lines = [NSString stringWithFormat:@"return @\"%@\";", operation.name];
	[object.methods addObject:method];
	[method release];
}

- (void) addContextInit:(GtCodeGeneratorObject*) object
					   initValues:(NSMutableDictionary*) initValues
{
	  GtCodeGeneratorMethod* initMethod = [[GtCodeGeneratorMethod alloc] init];
	  initMethod.name = @"init";
	  
	  initMethod.isPrivate = [NSNumber numberWithBool:YES];
	  initMethod.isStatic = [NSNumber numberWithBool:NO];
	  initMethod.returnType = @"id";
	  GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	  [builder appendLineWithFormat:@"if((self = [super init])) {"];
	  [builder tabIn];
	  for(NSString* key in initValues)
	  {
		[builder appendLineWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];",
			[initValues objectForKey:key], key];
	  }
	  [builder tabOut];
	  [builder appendLine:@"}"];
	  [builder appendLine:@"return self;"];
	  initMethod.code.lines = [builder toString];
	  [object.methods addObject:initMethod];
	  [initMethod release];
}


- (void) createNewOperationObject:(GtWsdlOperation*) operation 
	portName:(NSString*) portName
	codeSchema:(GtCodeGeneratorProject*) codeSchema
{
	GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
	bizObj.typeName = [NSString stringWithFormat:@"%@%@", portName, operation.name];
	bizObj.superclass = @"GtHttpOperation";
	bizObj.comment = operation.documentation;
	bizObj.canLazyCreateValue = YES;
	
	[m_operations addObject:bizObj];
	
	// add operation name property
//	GtCodeGeneratorProperty* opName = [[[GtCodeGeneratorProperty alloc] init] autorelease];
//	  opName.name = @"operationName";
//	  opName.type = @"string";
//	  opName.defaultValue = operation.name;
//	opName.isImmutable = [NSNumber numberWithBool:YES];
//	  opName.isPrivate = [NSNumber numberWithBool:YES];
//	[bizObj.properties addObject:opName];
	
//	[self addBehaviorInitializer:bizObj operation:operation codeSchema:codeSchema]; 
	[self addOperationName:bizObj operation:operation codeSchema:codeSchema]; 
	
//	GtCodeGeneratorProperty* input = 
		[self newPropertyForMessage:bizObj 
		isInput:YES 
		operation:operation 
		io:operation.input 
		overrideInputOutputNames:NO];

//	GtCodeGeneratorProperty* output = 
		[self newPropertyForMessage:bizObj 
		isInput:NO 
		operation:operation 
		io:operation.output
		overrideInputOutputNames:NO];

	


	[m_codeSchema.objects addObject:bizObj];
	[bizObj release];
}

- (GtCodeGeneratorProperty*) createBindingOperationObject:(GtWsdlOperation*) operation
{
	GtCodeGeneratorProperty* prop = [[[GtCodeGeneratorProperty alloc] init] autorelease];
	prop.name = operation.name;
	prop.type = @"string";
	prop.isImmutable = [NSNumber numberWithBool:YES];
	
	if(operation.operationObject)
	{
		GtWsdlOperation* childOperation = operation.operation;
	
		if(GtStringIsNotEmpty(childOperation.soapAction))
		{
			prop.defaultValue = childOperation.soapAction;
		}
		else if(GtStringIsNotEmpty(childOperation.location))
		{
			prop.defaultValue = childOperation.location;
		}
	}
	
	
	return prop;
}

- (NSString*) getServicePortLocationFromBinding:(GtWsdlBinding*) binding
{
	GtAssertIsValidString(binding.name);
	
	// this is attempting to get the binding attribute from the port element
	// in the parent service element, using the name of the bindings array
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
	for(GtWsdlPortType* port in m_definitions.service.ports)
	{
		if([port.binding isEqualToString:binding.type])
		{
			return port.address.location;
		}
	}
	
	GtThrowException(CodeGenFail, @"Service location string not found in service %@", m_definitions.service.name);
	
	return nil;
}

- (void) createServiceManager:(GtWsdlBinding*) binding 
{
	GtCodeGeneratorObject* bizObj = [[GtCodeGeneratorObject alloc] init];
	bizObj.typeName = binding.name;
	bizObj.superclass =	 @"GtNetworkServerContext";
	bizObj.isSingleton = [NSNumber numberWithBool:YES];

	
	NSString* url = [self getServicePortLocationFromBinding:binding];
	GtThrowIfStringEmpty(url);
	
	GtCodeGeneratorProperty* urlProp = [[[GtCodeGeneratorProperty alloc] init] autorelease];
	urlProp.name = @"url";
	urlProp.type = @"string";		
	urlProp.defaultValue = url;		   
	urlProp.isImmutable = [NSNumber numberWithBool:YES];
					
//	[bizObj.properties addObject:urlProp];
	
	GtCodeGeneratorProperty* targetNamespace = [[[GtCodeGeneratorProperty alloc] init] autorelease];
	targetNamespace.name = @"targetNamespace";	
	targetNamespace.type = @"string";	
			
	if(GtStringIsNotEmpty(m_definitions.targetNamespace))
	{
		targetNamespace.defaultValue = m_definitions.targetNamespace;
		targetNamespace.isImmutable = [NSNumber numberWithBool:YES];
	}
//	[bizObj.properties addObject:targetNamespace];
			
	NSMutableDictionary* initValues = [NSMutableDictionary dictionary];
	[initValues setObject:url forKey:GtNetworkServerPropertyKeyUrl];
	[initValues setObject:m_definitions.targetNamespace forKey:GtNetworkServerPropertyKeyTargetNamespace];

	for(GtWsdlOperation* op in binding.operations)
	{
		GtCodeGeneratorProperty* prop = 
			[self createBindingOperationObject:(GtWsdlOperation*) op];
		[initValues setObject:prop.defaultValue forKey:prop.name];
	}

	for(NSString* key in initValues)
	{
		NSString* value = [initValues objectForKey:key];
	
		[bizObj.initLines addObject:[NSString stringWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", value, key]];
	}

	

//	[self addContextInit:bizObj initValues:initValues];

	[m_codeSchema.objects addObject:bizObj];
	[bizObj release];
}

- (GtCodeGeneratorProperty*) propForName:(GtCodeGeneratorObject*) obj name:(NSString*) name
{
//	GtCodeGeneratorProperty* input = 

	for(GtCodeGeneratorProperty* prop in obj.properties)
	{
		if(GtStringsAreEqual(prop.name, name))
		{
			return prop;
		}
	
	}

	return nil;

} 


- (void) prepareObjects
{
	for(GtCodeGeneratorObject* obj in self.codeSchema.objects)
	{
		for(GtCodeGeneratorProperty* prop in obj.properties)
		{
			prop.type = [self fixTypeString:prop.type];
		}
	}
}

- (void) createObjectFromSimpleType:(GtWsdlSimpleType*) simpleType
	optionalName:(NSString*) optionalName
{
	if([simpleType restrictionObject])
	{
		GtCodeGeneratorEnumType* enumType = [GtCodeGeneratorEnumType codeGeneratorEnumType];

		enumType.typeName = optionalName ? optionalName : simpleType.name;

		for(GtWsdlEnumeration* wsdlEnum in simpleType.restriction.enumerations)
		{
		
			GtCodeGeneratorEnum* newEnum = [GtCodeGeneratorEnum codeGeneratorEnum];
			newEnum.name = wsdlEnum.value;
			
			[enumType.enums addObject:newEnum];
			
		}
		
		[m_codeSchema.enumTypes addObject:enumType];
	}
	
	if([simpleType listObject])
	{
		[self createObjectFromSimpleType:simpleType.list.simpleType optionalName:simpleType.name];
	}
}

- (void) createObjectFromElement:(GtWsdlElement*) element
{
	if([element complexTypeObject])
	{
		[self createObjectFromComplexType:element.complexType type:element.name];
	}
	else
	{
		[m_output appendLineWithFormat:@"Skipping element with no complexType content: %@", [[element description] trimmedStringWithNoLFCR]];
	}
}

- (void) buildCodeGeneratorSchemaFromWsdlDefinitions:(GtWsdlDefinitions*) definitions 
	codeSchema:(GtCodeGeneratorProject*) codeSchema
{
	codeSchema.canLazyCreate = [NSNumber numberWithBool:NO];

	GtCodeGeneratorTypeDefinition* define1 = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
	define1.typeName = @"GtNetworkServerContext";
	define1.import = @"GtNetworkServerContext.h";
	[codeSchema.typeDefinitions addObject:define1];

	GtCodeGeneratorTypeDefinition* define2 = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
	define2.typeName = @"GtHttpOperation";
	define2.import = @"GtHttpOperation.h";
	[codeSchema.typeDefinitions addObject:define2];

//	GtCodeGeneratorTypeDefinition* define3 = [GtCodeGeneratorTypeDefinition codeGeneratorTypeDefinition];
//	define3.typeName = @"GtNetworkEndpointHelper";
//	define3.import @"GtNetworkEndpointHelper.h";
//	[codeSchema.typeDefinitions addObject:define3];

	self.wsdlDefinitions = definitions;
	self.codeSchema = codeSchema;
	
	if(GtStringIsNotEmpty(definitions.documentation))
	{
		codeSchema.comment = definitions.documentation;
	}
	
	for(GtWsdlSchema* schema in definitions.types)
	{
		for(GtWsdlSimpleType* simpleType in schema.simpleTypes)
		{
			[self createObjectFromSimpleType:simpleType optionalName:nil];
		}
		for(GtWsdlComplexType* complexType in schema.complexTypes)
		{
			[self createObjectFromComplexType:complexType type:nil];
		}
		for(GtWsdlElement* element in schema.elements)
		{
			[self createObjectFromElement:element];
		}
	}
	for(GtWsdlMessage* message in definitions.messages)
	{
		[self createMessageObject:message];
	}
	for(GtWsdlBinding* binding in definitions.bindings)
	{
		[self createServiceManager:binding];  
	}
	for(GtWsdlPortType* portType in definitions.portTypes)
	{
		for(GtWsdlOperation* operation in portType.operations)
		{
			[self createNewOperationObject:operation portName:portType.name codeSchema:codeSchema];
		}
	}
	
	[self prepareObjects];
}

+ (GtWsdlDefinitions*) parseWsdl:(NSData*) xml
{
	GtSoapParser* parser = [[[GtSoapParser alloc] initWithXmlData:xml] autorelease];
	GtWsdlDefinitions* defs = [[[GtWsdlDefinitions alloc] init] autorelease];
	[parser buildObjects:defs];
	return defs;
}

- (void) buildCodeGeneratorSchema:(NSString*) fromFilePath 
	project:(GtCodeGeneratorProject*) project 
	codeSchema:(GtCodeGeneratorProject*) codeSchema
{
	NSData* xml = [NSData dataWithContentsOfURL:[NSURL URLWithString:project.fileUrl]];

	GtWsdlDefinitions* definitions = [GtWsdlTranslator parseWsdl:xml];

	[self buildCodeGeneratorSchemaFromWsdlDefinitions:definitions codeSchema:codeSchema];
	
	NSString* intermediatePath = [NSString stringWithFormat:@"%@.cgwsdl", [[project parentProjectPath] stringByDeletingLastPathComponent], project.schemaName];
	
	GtXmlBuilder* xmlBuilder = [[GtXmlBuilder alloc] init];
	[xmlBuilder addVersionAndEncodingHeader];
	[xmlBuilder openElement:@"schema"];

#if NEW_BUILDER
	[xmlBuilder addObjectAsXML:codeSchema];
#else
	[xmlBuilder streamObject:codeSchema];
#endif
	[xmlBuilder closeElement];
	
	[xmlBuilder.toString writeToFile:intermediatePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL) willTranslate:(NSString*) fileUrl
{
	return [fileUrl hasPrefix:@"http"];
}


@end

