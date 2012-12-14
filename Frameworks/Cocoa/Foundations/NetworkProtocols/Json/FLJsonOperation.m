//
//  FLJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonOperation.h"
#import "FLJsonParser.h"

@implementation FLJsonOperation

@synthesize outputObject = _outputObject;
@synthesize json = _json;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}


#if FL_MRC
- (void) dealloc {
    [_outputObject release];
	[_json release];
    [super dealloc];
}
#endif

- (FLResult) runSelf:(id) input {

    FLMutableHttpRequest* request = [FLMutableHttpRequest httpPostRequestWithURL:self.httpRequestURL];

    if(self.json && !self.json.isEmpty) {
        NSData* content = [[self.json buildStringWithNoWhitespace] dataUsingEncoding:NSUTF8StringEncoding];
        [request setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
    }
	
    FLHttpResponse* httpResponse = [self sendHttpRequest:request withAuthenticator:self.requestAuthenticator];
    
    FLJsonParser* parser = [FLJsonParser jsonParser];
    
    if(!_outputObject) {
        _outputObject = [NSMutableDictionary dictionary];
    }
    
    id result = [parser parseJsonData:[httpResponse responseData] rootObject:_outputObject];

    FLThrowError_(parser.error);
    FLThrowError_([httpResponse simpleHttpResponseErrorCheck]);
    
    return result;
}

@end

