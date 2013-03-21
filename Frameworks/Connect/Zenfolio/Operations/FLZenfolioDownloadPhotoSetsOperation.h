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

- (id) initWithGroup:(FLZenfolioGroup*) group objectStorage:(id<FLObjectStorage>) objectStorage;
+ (id) downloadPhotoSetsWithGroup:(FLZenfolioGroup*) group objectStorage:(id<FLObjectStorage>) objectStorage;

@end

@protocol  FLZenfolioDownloadPhotoSetsOperationObserver <NSObject>
@optional
- (void) photoSetDownloader:(FLZenfolioDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZenfolioPhotoSet*) photoSet; 
@end