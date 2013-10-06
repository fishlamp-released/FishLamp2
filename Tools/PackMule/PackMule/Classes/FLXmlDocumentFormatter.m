//
//  FLXmlDocumentFormatter.m
//  PackMule
//
//  Created by Mike Fullerton on 1/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLXmlDocumentFormatter.h"
#import "FLXmlParser.h"

#define XMLOPTIONS NSXMLNodePreserveCDATA | NSXMLNodeCompactEmptyElement | NSXMLDocumentTidyXML

@implementation FLXmlDocumentFormatter

+ (id) xmlDocumentFormatter {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSData*) xmlDataWithXMLString:(NSString*) string {
	NSXMLDocument* document = [self xmlDocumentWithXmlString:string];
	return [document XMLDataWithOptions:XMLOPTIONS];
}

- (NSXMLDocument*) xmlDocumentWithXmlString:(NSString*) string {

    NSError* err = nil;
	NSXMLDocument* document = FLAutorelease([[NSXMLDocument alloc] initWithXMLString:string options:XMLOPTIONS error:&err]);
	FLThrowIfError(err);
        
    return document;
}

- (NSString*) prettyPrintString:(NSString*) string {

	NSError* error = nil;
	NSXMLDocument* document = FLAutorelease([[NSXMLDocument alloc] initWithXMLString:string options:XMLOPTIONS error:&error]);
	FLThrowIfError(error);


    NSString* pretabbed = [document XMLStringWithOptions:NSXMLNodePrettyPrint|XMLOPTIONS];
    return [pretabbed stringByReplacingOccurrencesOfString:@"\t" withString:@"    "];
}

- (BOOL) canFormatCode:(NSString*) code {

    return [code rangeOfString:@"<?xml"].length > 0;


//    return [FLXmlParser canParseData:[code dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
