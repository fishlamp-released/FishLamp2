//
//  FLZfBITSCloseSessionHttpRequest.h
//  myZenfolio
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfBITSImageUploadHttpRequest.h"
#import "FLZfBitsUploadProtocolResponse.h"

@interface FLZfBITSCloseSessionHttpRequest : FLZfBITSImageUploadHttpRequest {
@private
    FLZfBitsUploadProtocolResponse* _sessionInfo;
    unsigned long long _fileSize;
}
- (id) initWithUploadablePhoto:(FLZfQueuedPhoto*) photo
                   sessionInfo:(FLZfBitsUploadProtocolResponse*) sessionInfo
                   fileSize:(unsigned long long) fileSize;
@end