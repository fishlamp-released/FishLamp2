//
//  FLJson.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonParser.h"
#import "FLObjectBuilder.h"

#if FL_ARC
#import "SBJsonParser.h"
#endif

@implementation FLJsonParser

@synthesize error = _error;

+ (FLJsonParser*) jsonParser {
    return autorelease_([[FLJsonParser alloc] init]);
}

- (void) dealloc {
    mrc_release_(_error);
    mrc_super_dealloc_();
}

- (NSError* )parseJsonData:(NSData *)data rootObject:(id) rootObject {
#if FL_ARC
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
            mrc_release_(builder);
            
            outObject = rootObject;
        }
    }    
    
    mrc_release_(parser);
    return outObject;
#endif
    
    FLAssertIsImplemented_v(@"SBJson requires ARC");
    
    return nil;
}

@end