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

        FLPrettyString* jsonString = [FLPrettyString prettyString:nil];
        [jsonString appendBuildableString:self.json];
        NSData* content = [jsonString.string dataUsingEncoding:NSUTF8StringEncoding];
        
        [self.requestBody setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
//    }
}

- (id) resultFromHttpResponse:(FLHttpResponse*) httpResponse {

    
    if(!_outputObject) {
        _outputObject = [NSMutableDictionary dictionary];
    }
    
    id jsonObject = [[FLJsonParser jsonParser] parseData:[httpResponse responseData]];
    
    
    
    
//    id result = [parser parseJsonData:[httpResponse responseData] rootObject:_outputObject withDecoder:self.dataDecoder];
//
//    FLThrowIfError(parser.error);
    
//    [httpResponse throwHttpErrorIfNeeded];
    
    return jsonObject;
}

@end

