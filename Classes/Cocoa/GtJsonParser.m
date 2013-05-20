//
//  GtJson.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJsonParser.h"
#import "GtObjectBuilder.h"

#import "SBJsonParser.h"

@implementation GtJsonParser

@synthesize error = m_error;

+ (GtJsonParser*) jsonParser
{
    return GtReturnAutoreleased([[GtJsonParser alloc] init]);
}

- (void) dealloc
{
    GtRelease(m_error);
    GtSuperDealloc();
}

- (NSError* )parseJsonData:(NSData *)data rootObject:(id) rootObject
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    
    id outObject = [parser objectWithData:data];			
    
    if(GtStringIsNotEmpty(parser.error))
    {	
        GtLog(@"JSON parse failed: %@", parser.error);

        self.error = [NSError errorWithDomain:GtJsonParserErrorDomain code:GtJsonParserParseFailedErrorCode localizedDescription:parser.error]; 

        
        outObject = nil;
    }
    else
    {
        if(rootObject)
        {
            GtObjectBuilder* builder = [[GtObjectBuilder alloc] init];
            [builder buildObjectsFromDictionary:outObject withRootObject:rootObject];
            GtRelease(builder);
            
            outObject = rootObject;
        }
    }    
    
    GtRelease(parser);

    return outObject;
}

@end