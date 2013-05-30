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

@implementation FLWsdlOperationCodeObject

// 	FLWsdlMessage* message = [self getMessageObject:io.message];	
//	FLConfirmNotNil(message);

//- (void) addPropertiesForWsdlMessage:(FLWsdlMessage*) message
//                             isInput:(BOOL) isInput
//                           operation:(FLWsdlOperation*) operation 
//                                  io:(FLWsdlInputOutput*) io
//            overrideInputOutputNames:(BOOL) overrideInputOutputNames {
//			
//	
//	BOOL setProperties = NO;
//	for(FLWsdlPart* part in message.parts) {
//
//		BOOL isElement = FLStringIsNotEmpty(part.element);
//		
//		if(!setProperties) {
//			setProperties = YES;
//			if(isInput) {
//                FLWsdlCodeProperty* opName = [self addProperty:@"includeInputNamespaceAttribute" propertyType:@"string"];
//                opName.isImmutable = YES;
//                opName.defaultValue = isElement ? @"YES" : @"NO";
//
//                FLWsdlCodeProperty* xmlParameterName = [self addProperty:@"operationParameterName" propertyType:@"string"];
//                xmlParameterName.isImmutable = YES;
//				xmlParameterName.defaultValue = isElement ? operation.name : part.name;
//
//			}
//		}
//
//        NSString* propertyType = nil;
//		if(isElement) {
//			propertyType = part.element;
//		}
//		else  {
//			NSString* type = part.type;
//
//FLAssertFailedWithComment(@"fixme");
//
//// FIXME "Not sure what this is doing, it's prob important tho"
////			if(FLStringIsNumber(type) || FLStringIsBool(type))
////			{
////				propertyType = message.name;
////			}
////			else
//            {
//				propertyType = type;
//			}
//		}
//		
//		if(FLStringIsEmpty(propertyType)) {
//			propertyType = @"string";
//		}
//	
//        NSString* propertyName = part.name;
//		if(message.parts.count == 1 && overrideInputOutputNames) {
//			propertyName = isInput ? @"input" : @"output";
//		}
//    
//        [self addProperty:propertyName propertyType:propertyType];
//		
////		[object.properties addObject:outProp];
//	}
//}



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
    
    FLWsdlCodeProperty* property = [self addProperty:@"operationName" propertyType:@"string"];
    property.isPrivate = YES;
    property.isStatic = YES;
    property.defaultValue = [NSString stringWithFormat:@"@\"%@\"", operation.name];
}

- (void) addInitWithValues:(NSMutableDictionary*) initValues {
//
//    FLWsdlCodeMethod* initMethod = [self addMethod:@"init" methodReturnType:@"id"];
//    initMethod.isPrivate = YES;
//    initMethod.isStatic = NO;
//
//    FLPrettyString* builder = [FLPrettyString prettyString];
//
//    [builder appendLineWithFormat:@"if((self = [super init])) {"];
//    [builder indent: ^{
//        for(NSString* key in initValues) {
//            [builder appendLineWithFormat:@"[self.properties setObject:@\"%@\" forKey:@\"%@\"];", [initValues objectForKey:key], key];
//        }
//    }];
//
//    [builder appendLine:@"}"];
//    [builder appendLine:@"return self;"];
//    
//    [initMethod addLines:[builder string]];
}

+ (id) wsdlOperationCodeObject:(FLWsdlOperation*) operation 
                      portType:(FLWsdlPortType*) portType 
                    codeReader:(FLWsdlCodeProjectReader*) codeReader {
	
    FLWsdlOperationCodeObject* object = [FLWsdlOperationCodeObject wsdlCodeObject:[NSString stringWithFormat:@"%@%@", portType.name, operation.name]
                                                                                              superclassName:/*@"FLHttpOperation"*/ nil];
                                                                                              
	object.comment = operation.documentation;
	
	
	[object addOperationNameProperty:operation]; 
	   
    [object addPropertiesForWsdlMessage:[codeReader wsdlMessageForName:operation.input.message]
                        isInput:YES 
                      operation:operation 
                             io:operation.input 
       overrideInputOutputNames:NO];

    [object addPropertiesForWsdlMessage:[codeReader wsdlMessageForName:operation.output.message] 
                        isInput:NO 
                      operation:operation 
                             io:operation.output
       overrideInputOutputNames:NO];


    return object;
}


@end
