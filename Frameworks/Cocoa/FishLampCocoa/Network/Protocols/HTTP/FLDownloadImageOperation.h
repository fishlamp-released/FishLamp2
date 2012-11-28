//
//  FLDownloadImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLCachedImage.h"
#import "FLImage.h"



@interface FLDownloadImageBytesOperation : FLHttpOperation {
@private
}

@end


@interface FLDownloadImageOperation : FLDownloadImageBytesOperation {
@private
    id<FLImageStorageStrategy> _storageStrategy;
}

- (id) initWithImageURL:(NSURL*) imageURL;

- (id) initWithImageURL:(NSURL*) imageURL 
        storageStrategy:(id<FLImageStorageStrategy>) storageStrategy;

@end