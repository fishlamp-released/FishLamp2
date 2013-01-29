//
//  FLZfSoapHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapHttpRequest.h"
#import "FLZfApiSoap.h"
#import "FLZfSoapError.h"

@interface FLZfSoapHttpRequest : FLSoapHttpRequest
- (id) initWithGeneratedObject:(id) object serverInfo:(FLZfApiSoap*) info;
+ (id) soapHttpRequestWithGeneratedObject:(id) httpRequest serverInfo:(FLZfApiSoap*) info; 
@end