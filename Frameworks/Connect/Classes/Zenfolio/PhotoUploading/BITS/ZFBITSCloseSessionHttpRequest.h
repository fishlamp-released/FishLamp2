//
//  ZFBITSCloseSessionHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#if REFACTOR

#import "ZFBITSImageUploadHttpRequest.h"
#import "ZFBitsUploadProtocolResponse.h"

@interface ZFBITSCloseSessionHttpRequest : ZFBITSImageUploadHttpRequest {
@private
    ZFBitsUploadProtocolResponse* _sessionInfo;
    unsigned long long _fileSize;
}
- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo
                   sessionInfo:(ZFBitsUploadProtocolResponse*) sessionInfo
                   fileSize:(unsigned long long) fileSize;
@end
#endif