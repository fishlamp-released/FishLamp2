//
//  FLJson.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonParser.h"

@implementation FLJsonParser

+ (FLJsonParser*) jsonParser {
    return FLAutorelease([[FLJsonParser alloc] init]);
}

- (id) parseData:(NSData*) data {
    NSError* error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    FLThrowIfError(object);
    
    return object;
}

- (id) parseFileAtPath:(NSString*) path {
    return [self parseFileAtURL:[NSURL fileURLWithPath:path]];
}

- (id) parseFileAtURL:(NSURL*) url {
    NSError* err = nil;
    NSData* data = [NSData dataWithContentsOfURL:url options:0  error:&err];
    FLThrowIfError(FLAutorelease(err));
        
    return [self parseData:data];
}
//#if REFACTOR
//#if FL_ARC
//    SBJsonParser* parser = [[SBJsonParser alloc] init];
//    
//    id outObject = [parser objectWithData:data];			
//    
//    if(FLStringIsNotEmpty(parser.error))
//    {	
//        FLDebugLog(@"JSON parse failed: %@", parser.error);
//
//        self.error = [NSError errorWithDomain:FLJsonParserErrorDomain code:FLJsonParserParseFailedErrorCode localizedDescription:parser.error]; 
//
//        
//        outObject = nil;
//    }
//    else
//    {
//        if(rootObject) {
//            FLObjectBuilder* builder = [[FLObjectBuilder alloc] init];  
//            [builder buildObjectsFromDictionary:outObject withRootObject:rootObject withDecoder:decoder];
//            FLRelease(builder);
//            
//            outObject = rootObject;
//        }
//    }    
//    
//    FLRelease(parser);
//    return outObject;
//#endif
//#endif
//    
//    FLAssertIsImplementedWithComment(@"SBJson requires ARC");
//    
//    return nil;
//}

@end