//
//  ZFImageDownloadingService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "ZFPhoto.h"
#import "ZFPhotoInfo.h"
#import "ZFImageSize.h"

@interface ZFImageDownloadingService : FLService

+ (id) imageDownloadingService;

- (id) downloadImageOperationForPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

@end

FLPublishService(imageDownloadingService, ZFImageDownloadingService*)