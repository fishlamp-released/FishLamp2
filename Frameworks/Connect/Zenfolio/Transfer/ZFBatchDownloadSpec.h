//
//  ZFBatchDownloadSpec.h
//  FishLamp
//
//  Created by Mike Fullerton on 4/5/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorage.h"
#import "ZFTransferState.h"
#import "FLModelObject.h"

@interface ZFBatchDownloadSpec : FLIdentifiedObject<FLModelObject> {
@private
    NSSet* _photoSets;
    NSInteger _rootGroupID;
    NSString* _destinationPath;
    NSArray* _mediaTypes;
    ZFTransferState* _transferState;
}

@property (readwrite, assign, nonatomic) NSInteger rootGroupID;
@property (readwrite, copy, nonatomic) NSSet* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
@property (readwrite, copy, nonatomic) NSArray* mediaTypes;
@property (readwrite, strong) ZFTransferState* transferState;

+ (id) batchDownloadSpec;
+ (id) batchDownloadSpecFromUserDefaults;

- (void) saveToUserDefaults;

@end
