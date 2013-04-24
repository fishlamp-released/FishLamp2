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

@interface ZFBatchDownloadSpec : FLModelObject {
@private
    NSSet* _photoSets;
    NSInteger _rootGroupID;
    NSString* _destinationPath;
    NSArray* _mediaTypes;
}

@property (readwrite, assign, nonatomic) NSInteger rootGroupID;
@property (readwrite, copy, nonatomic) NSSet* photoSets;
@property (readwrite, copy, nonatomic) NSString* destinationPath;
@property (readwrite, copy, nonatomic) NSArray* mediaTypes;

+ (id) batchDownloadSpec;
+ (id) batchDownloadSpecFromUserDefaults;

- (void) saveToUserDefaults;

@end
