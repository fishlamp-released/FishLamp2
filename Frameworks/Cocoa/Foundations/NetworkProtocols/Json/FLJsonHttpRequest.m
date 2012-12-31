//
//  FLJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonHttpRequest.h"
#import "FLJsonParser.h"

@implementation FLJsonHttpRequest

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

- (void) willSendHttpRequest {
//    if(self.json && self.json.lines.count > 0) {
        NSData* content = [[self.json buildStringWithNoWhitespace] dataUsingEncoding:NSUTF8StringEncoding];
        [self.body setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
//    }
}

- (id) resultFromHttpResponse:(FLHttpResponse*) httpResponse {

    FLJsonParser* parser = [FLJsonParser jsonParser];
    
    if(!_outputObject) {
        _outputObject = [NSMutableDictionary dictionary];
    }
    
    id result = [parser parseJsonData:[httpResponse responseData] rootObject:_outputObject];

    FLThrowError(parser.error);
    
    [httpResponse throwHttpErrorIfNeeded];
    
    return result;
}

@end

