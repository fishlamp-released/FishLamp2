//
//  FLZenfolioSoapHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapHttpRequest.h"
#import "FLZenfolioApiSoap.h"
#import "FLZenfolioSoapError.h"

@interface FLZenfolioSoapHttpRequest : FLSoapHttpRequest
- (id) initWithGeneratedObject:(id) object serverInfo:(FLZenfolioApiSoap*) info;
+ (id) soapHttpRequestWithGeneratedObject:(id) httpRequest serverInfo:(FLZenfolioApiSoap*) info; 
@end