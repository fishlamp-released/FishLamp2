//
//	WsdlCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/9/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GtCodeGeneratorProjectManager.h"
#import "GtWsdlSchemaAll.h"

@interface GtWsdlTranslator : NSObject<GtCodeTranslator> {
	GtCodeGeneratorProject* m_codeSchema;
	GtWsdlDefinitions* m_definitions;
	GtStringBuilder* m_output;
	
	NSMutableArray* m_operations;
}

@property (readwrite, assign, nonatomic) GtCodeGeneratorProject* codeSchema;
@property (readwrite, assign, nonatomic) GtWsdlDefinitions* wsdlDefinitions;
@property (readwrite, assign, nonatomic) GtStringBuilder* output;


+ (GtWsdlDefinitions*) parseWsdl:(NSData*) data;

- (void) buildCodeGeneratorSchemaFromWsdlDefinitions:(GtWsdlDefinitions*) definitions 
	codeSchema:(GtCodeGeneratorProject*) codeSchema;


@end
