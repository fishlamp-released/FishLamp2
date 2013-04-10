//
//  ZFBITSUploadFragment.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "ZFQueuedPhoto.h"
#import "FLStorableImage.h"
#import "ZFBitsUploadProtocolResponse.h"
#import "ZFBITSImageUploadHttpRequest.h"

@interface ZFBITSUploadFragment: ZFBITSImageUploadHttpRequest {
@private
	FLStorableImage* _imageFile;
    unsigned long long _fileOffset;
    unsigned long long _chunkSize;
    unsigned long long _fileSize;
    unsigned long long _amountWritten;
    ZFBitsUploadProtocolResponse* _sessionInfo;
}

@property (readonly, assign, nonatomic) unsigned long long amountWritten;

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo 
                 preparedImage:(FLStorableImage*) image
                   startOffset:(unsigned long long) startOffset
                     chunkSize:(unsigned long long) chunkSize
                     fileSize:(unsigned long long) fileSize
                   sessionInfo:(ZFBitsUploadProtocolResponse*) sessionInfo;

@end
#endif