//
//  FLJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonOperation.h"
#import "FLJsonParser.h"

@interface FLJsonOperation ()
@end

@implementation FLJsonOperation

synthesize_(json);

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

dealloc_(
	[_json release];
)

- (void) runSelf {

    if(self.json && !self.json.isEmpty) {
        NSData* content = [[self.json buildStringWithNoWhitespace] dataUsingEncoding:NSUTF8StringEncoding];
        [self.httpRequest setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
    }
	
    [super runSelf];
    
    if(!self.error) {
        FLJsonParser* parser = [FLJsonParser jsonParser];
        
        if(!self.output) {
            self.output = [NSMutableDictionary dictionary];
        }
        
        self.operationOutput = [parser parseJsonData:self.httpResponse.responseData rootObject:self.output];

        FLThrowError_(parser.error);
        FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
    }
}

@end

