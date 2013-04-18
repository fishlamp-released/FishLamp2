//
//  ZFDownloadPhotoSetsOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"

#import "ZFGroup.h"

// returns group

@interface ZFDownloadPhotoSetsOperation : FLSynchronousOperation {
@private
    ZFGroup* _group;
    
    SEL _downloadedPhotoSetSelector;
}

@property (readwrite, assign, nonatomic) SEL downloadedPhotoSetSelector;

- (id) initWithGroup:(ZFGroup*) group;
+ (id) downloadPhotoSetsWithGroup:(ZFGroup*) group;

@end

@protocol  ZFDownloadPhotoSetsOperationObserver <NSObject>
@optional

- (void) photoSetComposer:(ZFDownloadPhotoSetsOperation*) operation 
        didDownloadPhotoSet:(ZFPhotoSet*) photoSet; 
@end