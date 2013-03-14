//
//  FLSoapParser.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSoapParser.h"

@implementation FLSoapParser 

+ (id) soapParser {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser {
	[parser setShouldProcessNamespaces:YES];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}

- (NSDictionary*) bodyContentsForDictionary:(NSDictionary*) soap {
    NSDictionary* outDict = [soap objectForKey:@"Envelope"];
    outDict = [outDict objectForKey:@"Body"];
    outDict = [[outDict allValues] firstObject];
    return outDict;
}

@end
