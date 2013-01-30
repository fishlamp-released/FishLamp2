//
//  FLZenfolioBitsUploadProtocolResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "__FLZenfolioBitsUploadProtocolResponse.h"

#define FLZenfolioBitsUploaderErrorDomain @"FLZenfolioBitsUploaderErrorDomain"
#define FLZenfolioServerError 5

@interface FLZenfolioBitsUploadProtocolResponse (HTTPHeaders)
- (NSError*) setDataWithHTTPHeaders:(NSDictionary*) headers;
@end
