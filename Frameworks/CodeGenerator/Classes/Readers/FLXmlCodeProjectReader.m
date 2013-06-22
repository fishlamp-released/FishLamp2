//
//  XmlCodeReader.m
//  XmlCodeReader
//
//  Created by Mike Fullerton on 6/16/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLXmlCodeProjectReader.h"
#import "FLXmlParser.h"
#import "FLXmlObjectBuilder.h"

#import "FLCodeProject.h"
#import "FLCodeProjectLocation.h"

@implementation FLXmlCodeProjectReader

+ (FLXmlCodeProjectReader*) xmlCodeProjectReader {
    return FLAutorelease([[FLXmlCodeProjectReader alloc] init]);
}

- (FLCodeProject *) parseProjectFromData:(NSData*) data {

    FLParsedXmlElement* parsedXml = nil;
    @try {
        parsedXml = [[FLXmlParser xmlParser] parseData:data];
    }
    @catch(NSException* ex) {
        
        return nil;
    }
    
    if(FLStringsAreEqual(@"fishlamp", parsedXml.elementName)) {
    
        FLXmlObjectBuilder* builder = [FLXmlObjectBuilder xmlObjectBuilder:[FLDataEncoder dataEncoder]];
        builder.strict = YES;
        
        FLCodeProject* project = [FLCodeProject objectWithXmlElement:parsedXml withObjectBuilder:builder];
        FLAssertNotNil(project);
        
        return project;
    }
    
    
    return nil;
//    parser.saveParsePositions = YES;

//    FLCodeProject* project = [FLCodeProject project];
//    [parser buildObjects:project];
//    return project;
}


@end
