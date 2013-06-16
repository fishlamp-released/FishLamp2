//
//  FLWsdlOperationCodeObject.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlOperationCodeObject.h"
#import "FLWsdlOperation.h"
#import "FLWsdlPortType.h"
#import "FLWsdlInputOutput.h"
#import "FLWsdlMessage.h"
#import "FLWsdlPart.h"
#import "FLWsdlCodeProperty.h"
#import "FLWsdlCodeMethod.h"
#import "FLWsdlCodeProjectReader.h"
#import "FLWsdlBinding.h"
#import "FLWsdlDefinitions.h"
#import "FLCodeElementsAll.h"
#import "FLHttpRequest.h"

@implementation FLWsdlOperationCodeObject

- (id) init {	
	self = [super init];
	if(self) {
    }
	return self;
}

- (void) addPropertiesForWsdlMessage:(FLWsdlMessage*) message
                             isInput:(BOOL) isInput
                           operation:(FLWsdlOperation*) operation 
                                  io:(FLWsdlInputOutput*) io
            overrideInputOutputNames:(BOOL) overrideInputOutputNames {
      
//	FLWsdlMessage* message = [self getMessageObject:io.message];	
//	FLConfirmNotNil(message);
	
    NSString* propertyType = message.name;
	
	if(message.parts.count) {
		FLWsdlPart* part = [message.parts objectAtIndex:0];
		BOOL isElement = FLStringIsNotEmpty(part.element);
		if(isElement && message.parts.count == 1) {
			// this means we'll be using a different object here, and we don't need a message object.
			// this is for an input/output object
			
			// note that this if for wsdl:part that has elements, not type.
			
			//			  <wsdl:message name="GetChallengeSoapIn">
			//			  <wsdl:part name="parameters" element="tns:GetChallenge"/>
			//			  </wsdl:message>
			
			propertyType = part.element;
		}
	} 

    [self addProperty:isInput ? @"input" : @"output" propertyType:propertyType];
}


- (void) addOperationNameProperty:(FLWsdlOperation*) operation {
    
    if([self propertyForName:@"operationName"] == nil) {
        FLWsdlCodeProperty* property = [self addProperty:@"operationName" propertyType:@"string"];
        property.isReadOnly = YES;
        property.isImmutable = YES;
        property.defaultValue = [FLCodeStatement codeStatement:
                                    [FLCodeReturn codeReturn:
                                        [FLCodeString codeString:operation.name]]];
    }
}

//- (void) addInitWithValues:(NSMutableDictionary*) initValues {
////
////    FLWsdlCodeMethod* initMethod = [self addMethod:@"init" methodReturnType:@"id"];
////    initMethod.isPrivate = YES;
////    initMethod.isStatic = NO;
////
////    FLPrettyString* builder = [FLPrettyString prettyString];
////
////    [builder appendLineWithFormat:@"if((self = [super init])) {"];
////    [builder indent: ^{
////        for(NSString* key in initValues) {
////            [builder appendLineWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", [initValues objectForKey:key], key];
////        }
////    }];
////
////    [builder appendLine:@"}"];
////    [builder appendLine:@"return self;"];
////    
////    [initMethod addLines:[builder string]];
//}

//+ (NSString*) operationClassName:(NSString*) binding operationName:(NSString*) operationName {
//    return [NSString stringWithFormat:@"%@%@", binding, operationName];
//}


- (id) initWithClassName:(NSString*) className {	
	self = [super init];
	if(self) {
		self.className = className;
	}
	return self;
}

+ (id) wsdlOperationCodeObject:(NSString*) className {

    return FLAutorelease([[[self class] alloc] initWithClassName:className]);
}     

- (void) addPropertiesWithOperation:(FLWsdlOperation*) operation codeReader:(FLWsdlCodeProjectReader*) codeReader  {
    
    if(FLStringIsNotEmpty(operation.documentation)) {
        self.comment = operation.documentation;
    }
    
  	[self addOperationNameProperty:operation]; 
    
    if(operation.input.message) {
        [self addPropertiesForWsdlMessage:[codeReader wsdlMessageForName:operation.input.message]
                            isInput:YES 
                          operation:operation 
                                 io:operation.input 
           overrideInputOutputNames:NO];
    }

    if(operation.output.message) {
        [self addPropertiesForWsdlMessage:[codeReader wsdlMessageForName:operation.output.message] 
                            isInput:NO 
                          operation:operation 
                                 io:operation.output
           overrideInputOutputNames:NO];
    }
}               

- (void) addPropertiesWithPortType:(FLWsdlPortType*) portType  codeReader:(FLWsdlCodeProjectReader*) reader {

}


- (void) addPropertiesWithBinding:(FLWsdlBinding*) binding withOperation:(FLWsdlOperation*) operation codeReader:(FLWsdlCodeProjectReader*) reader {
    
    [self addPropertiesWithOperation:operation codeReader:reader];

    NSString* url = [reader servicePortLocationFromBinding:binding];		   
    FLConfirmStringIsNotEmpty(url);
    
    NSString* targetNamespace = reader.wsdlDefinitions.targetNamespace;
    FLConfirmStringIsNotEmpty(targetNamespace);

    if(FLStringIsNotEmpty(targetNamespace) && [self propertyForName:@"targetNamespace"] == nil) {
        FLWsdlCodeProperty* prop = [self addProperty:@"targetNamespace" propertyType:@"string"];
        prop.isImmutable = YES;
        prop.isReadOnly = YES;
        prop.defaultValue = [FLCodeStatement codeStatement:
                                [FLCodeReturn codeReturn:
                                    [FLCodeString codeString:targetNamespace]]];
    }

    if(FLStringIsNotEmpty(binding.binding.verb) && [self propertyForName:@"verb"] == nil) {
        FLWsdlCodeProperty* prop = [self addProperty:@"verb" propertyType:@"string"];
        prop.isImmutable = YES;
        prop.isReadOnly = YES;
        prop.defaultValue = [FLCodeStatement codeStatement:
                                [FLCodeReturn codeReturn:
                                    [FLCodeString codeString:binding.binding.verb]]];
    }
    
    if(FLStringIsNotEmpty(binding.binding.transport) && [self propertyForName:@"transport"] == nil) {
        FLWsdlCodeProperty* prop = [self addProperty:@"transport" propertyType:@"string"];
        prop.isImmutable = YES;
        prop.isReadOnly = YES;
        prop.defaultValue = [FLCodeStatement codeStatement:
                                [FLCodeReturn codeReturn:
                                    [FLCodeString codeString:binding.binding.transport]]];
    }

    NSString* location = url;
    
    FLWsdlOperation* subOperation = operation.operation;
    if(subOperation) {
        if(FLStringIsNotEmpty(subOperation.soapAction)) {
            FLWsdlCodeProperty* prop = [self addProperty:@"soapAction" propertyType:@"string"];
            prop.isImmutable = YES;
            prop.isReadOnly = YES;
            prop.defaultValue = [FLCodeStatement codeStatement:
                                    [FLCodeReturn codeReturn:
                                        [FLCodeString codeString:subOperation.soapAction]]];
        }
        
        if(FLStringIsNotEmpty(subOperation.location)) {
            location = [url stringByAppendingPathComponent:subOperation.location];
        }
    }

    FLWsdlCodeProperty* prop = [self addProperty:@"location" propertyType:@"string"];
    prop.isImmutable = YES;
    prop.isReadOnly = YES;
    prop.defaultValue = [FLCodeStatement codeStatement:
                            [FLCodeReturn codeReturn:
                                [FLCodeString codeString:location]]];
    
//    FLWsdlCodeMethod* method = [FLWsdlCodeMethod wsdlCodeMethod:@"init" methodReturnType:@"id"];
    
}


@end
