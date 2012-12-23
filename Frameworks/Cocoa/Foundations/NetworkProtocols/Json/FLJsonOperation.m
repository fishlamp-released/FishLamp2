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

- (FLResult) runOperationWithInput:(id) input {

    FLHttpRequest* request = [FLHttpRequest httpPostRequestWithURL:self.httpRequestURL];

    if(self.json && !self.json.isEmpty) {
        NSData* content = [[self.json buildStringWithNoWhitespace] dataUsingEncoding:NSUTF8StringEncoding];
        [request.httpBody setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
    }
	
    FLHttpResponse* httpResponse = [self sendHttpRequest:request];
    
    FLJsonParser* parser = [FLJsonParser jsonParser];
    
    if(!_outputObject) {
        _outputObject = [NSMutableDictionary dictionary];
    }
    
    id result = [parser parseJsonData:[httpResponse responseData] rootObject:_outputObject];

    FLThrowError(parser.error);
    FLThrowError([httpResponse simpleHttpResponseErrorCheck]);
    
    return result;
}

@end

