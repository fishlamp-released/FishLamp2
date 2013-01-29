//
//  ZFDownloadPhotoSetsOperation.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

#import "ZFGroup.h"

// returns group

@interface ZFDownloadPhotoSetsOperation : FLOperation {
@private
    ZFGroup* _group;
}

- (id) initWithGroup:(ZFGroup*) group;
+ (id) downloadPhotoSetsWithGroup:(ZFGroup*) group;

@end

@protocol  ZFPhotoSetDownloaderObserver <NSObject>
@optional
- (void) photoSetDownloader:(ZFDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(ZFPhotoSet*) photoSet; 
@end