//
//	WsdlCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/9/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLCodeProjectReader.h"
@class FLCodeProject;
@class FLCodeBuilder;
@class FLParsedXmlElement;
@class FLWsdlDefinitions;

@interface FLWsdlCodeProjectReader : NSObject<FLCodeProjectReader> {
@private
    FLCodeProject* _project;
    FLWsdlDefinitions* _wsdlDefinitions;
    
    FLCodeBuilder* _output;
	NSMutableArray* _operations;
}

+ (FLWsdlCodeProjectReader*) wsdlCodeReader;
@end
