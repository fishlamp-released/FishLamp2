//
//  ZFSoapHttpRequest.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapHttpRequest.h"
#import "ZFApiSoap.h"
#import "ZFSoapError.h"

@interface ZFSoapHttpRequest : FLSoapHttpRequest
- (id) initWithGeneratedObject:(id) object serverInfo:(ZFApiSoap*) info;
+ (id) soapHttpRequestWithGeneratedObject:(id) httpRequest serverInfo:(ZFApiSoap*) info; 
@end