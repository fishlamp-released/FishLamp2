//
//  FLZenfolioBITSCloseSessionHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioBITSImageUploadHttpRequest.h"
#import "FLZenfolioBitsUploadProtocolResponse.h"

@interface FLZenfolioBITSCloseSessionHttpRequest : FLZenfolioBITSImageUploadHttpRequest {
@private
    FLZenfolioBitsUploadProtocolResponse* _sessionInfo;
    unsigned long long _fileSize;
}
- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo
                   sessionInfo:(FLZenfolioBitsUploadProtocolResponse*) sessionInfo
                   fileSize:(unsigned long long) fileSize;
@end