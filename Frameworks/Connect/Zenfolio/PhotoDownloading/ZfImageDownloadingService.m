//
//  ZFImageDownloadingService.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFImageDownloadingService.h"
#import "FLZenfolioDownloadImageHttpRequest.h"
#import "FLHttpRequest.h"

@implementation ZFImageDownloadingService

+ (id) imageDownloadingService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) downloadImageOperationForPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize {
    FLZenfolioDownloadImageHttpRequest* operation = [FLZenfolioDownloadImageHttpRequest downloadImageOperation:photo imageSize:imageSize];
//    operation.session = self.context;
    return operation;
}
@end
