//
//  ZFImageDownloadingService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLZenfolioPhoto.h"
#import "FLZenfolioPhotoInfo.h"
#import "FLZenfolioImageSize.h"

@interface ZFImageDownloadingService : FLService

+ (id) imageDownloadingService;

- (id) downloadImageOperationForPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

@end

FLPublishService(imageDownloadingService, ZFImageDownloadingService*)