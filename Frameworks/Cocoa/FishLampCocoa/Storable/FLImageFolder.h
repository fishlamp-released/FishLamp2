//
//  FLFileAssetStorage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageStorage.h"
#import "FLFolder.h"

@interface FLImageFolder : NSObject<FLImageStorage> {
@private
    FLFolder* _folder;
}

- (id) initWithFolder:(FLFolder*) folder;

@end
