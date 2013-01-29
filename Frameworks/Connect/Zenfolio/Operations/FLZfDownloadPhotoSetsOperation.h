//
//  FLZfDownloadPhotoSetsOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

#import "FLZfGroup.h"

// returns group

@interface FLZfDownloadPhotoSetsOperation : FLOperation {
@private
    FLZfGroup* _group;
}

- (id) initWithGroup:(FLZfGroup*) group;
+ (id) downloadPhotoSetsWithGroup:(FLZfGroup*) group;

@end

@protocol  FLZfPhotoSetDownloaderObserver <NSObject>
@optional
- (void) photoSetDownloader:(FLZfDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZfPhotoSet*) photoSet; 
@end