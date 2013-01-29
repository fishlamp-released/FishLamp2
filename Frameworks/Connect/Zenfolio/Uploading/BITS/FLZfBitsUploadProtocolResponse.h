//
//  FLZfBitsUploadProtocolResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "__ZFBitsUploadProtocolResponse.h"

#define FLZfBitsUploaderErrorDomain @"FLZfBitsUploaderErrorDomain"
#define FLZfServerError 5

@interface FLZfBitsUploadProtocolResponse (HTTPHeaders)
- (NSError*) setDataWithHTTPHeaders:(NSDictionary*) headers;
@end
