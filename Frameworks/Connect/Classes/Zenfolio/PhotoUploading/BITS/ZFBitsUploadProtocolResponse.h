//
//  ZFBitsUploadProtocolResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "__ZFBitsUploadProtocolResponse.h"

#define ZFBitsUploaderErrorDomain @"ZFBitsUploaderErrorDomain"
#define ZFServerError 5

@interface ZFBitsUploadProtocolResponse (HTTPHeaders)
- (NSError*) setDataWithHTTPHeaders:(NSDictionary*) headers;
@end
