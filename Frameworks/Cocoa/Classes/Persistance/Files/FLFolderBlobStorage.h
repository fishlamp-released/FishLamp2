//
//  FLFolderBlobStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFolder.h"
#import "FLBlobStorage.h"

@interface FLFolderBlobStorage : NSObject<FLBlobStorage> {
@private
    FLFolder* _folder;
}

@property (readonly, strong) FLFolder* folder;

- (id) initWithFolder:(FLFolder*) folder;
+ (id) blobFolderStorage:(FLFolder*) folder;


@end
