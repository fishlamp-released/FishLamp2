//
//  FLZenfolioBITSUploadFragment.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioQueuedPhoto.h"
#import "FLStorableImage.h"
#import "FLZenfolioBitsUploadProtocolResponse.h"
#import "FLZenfolioBITSImageUploadHttpRequest.h"

@interface FLZenfolioBITSUploadFragment: FLZenfolioBITSImageUploadHttpRequest {
@private
	FLStorableImage* _imageFile;
    unsigned long long _fileOffset;
    unsigned long long _chunkSize;
    unsigned long long _fileSize;
    unsigned long long _amountWritten;
    FLZenfolioBitsUploadProtocolResponse* _sessionInfo;
}

@property (readonly, assign, nonatomic) unsigned long long amountWritten;

- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo 
                 preparedImage:(FLStorableImage*) image
                   startOffset:(unsigned long long) startOffset
                     chunkSize:(unsigned long long) chunkSize
                     fileSize:(unsigned long long) fileSize
                   sessionInfo:(FLZenfolioBitsUploadProtocolResponse*) sessionInfo;

@end
