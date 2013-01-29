//
//  FLZfBITSUploadFragment.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfQueuedPhoto.h"
#import "FLStorableImage.h"
#import "FLZfBitsUploadProtocolResponse.h"
#import "FLZfBITSImageUploadHttpRequest.h"

@interface FLZfBITSUploadFragment: FLZfBITSImageUploadHttpRequest {
@private
	FLStorableImage* _imageFile;
    unsigned long long _fileOffset;
    unsigned long long _chunkSize;
    unsigned long long _fileSize;
    unsigned long long _amountWritten;
    FLZfBitsUploadProtocolResponse* _sessionInfo;
}

@property (readonly, assign, nonatomic) unsigned long long amountWritten;

- (id) initWithUploadablePhoto:(FLZfQueuedPhoto*) photo 
                 preparedImage:(FLStorableImage*) image
                   startOffset:(unsigned long long) startOffset
                     chunkSize:(unsigned long long) chunkSize
                     fileSize:(unsigned long long) fileSize
                   sessionInfo:(FLZfBitsUploadProtocolResponse*) sessionInfo;

@end
