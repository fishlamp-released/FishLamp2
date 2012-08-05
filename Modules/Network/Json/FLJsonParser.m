//
//  FLJson.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonParser.h"
#import "FLObjectBuilder.h"

#import "SBJsonParser.h"

@implementation FLJsonParser

@synthesize error = _error;

+ (FLJsonParser*) jsonParser
{
    return FLReturnAutoreleased([[FLJsonParser alloc] init]);
}

- (void) dealloc
{
    FLRelease(_error);
    FLSuperDealloc();
}

- (NSError* )parseJsonData:(NSData *)data rootObject:(id) rootObject
{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    
    id outObject = [parser objectWithData:data];			
    
    if(FLStringIsNotEmpty(parser.error))
    {	
        FLDebugLog(@"JSON parse failed: %@", parser.error);

        self.error = [NSError errorWithDomain:FLJsonParserErrorDomain code:FLJsonParserParseFailedErrorCode localizedDescription:parser.error]; 

        
        outObject = nil;
    }
    else
    {
        if(rootObject)
        {
            FLObjectBuilder* builder = [[FLObjectBuilder alloc] init];
            [builder buildObjectsFromDictionary:outObject withRootObject:rootObject];
            FLRelease(builder);
            
            outObject = rootObject;
        }
    }    
    
    FLRelease(parser);

    return outObject;
}

@end