//
//  FLZenfolioDownloadPhotoSetsOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

#import "FLZenfolioGroup.h"

// returns group

@interface FLZenfolioDownloadPhotoSetsOperation : FLOperation {
@private
    FLZenfolioGroup* _group;
}

- (id) initWithGroup:(FLZenfolioGroup*) group;
+ (id) downloadPhotoSetsWithGroup:(FLZenfolioGroup*) group;

@end

@protocol  FLZenfolioDownloadPhotoSetsOperationObserver <NSObject>
@optional
- (void) photoSetDownloader:(FLZenfolioDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZenfolioPhotoSet*) photoSet; 
@end