//
//  ZFPhotoIdentifier.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBlobStorage.h"

@interface ZFPhotoIdentifier : NSObject<FLBlobIdentifier> {
@private
    ZFGroup* _rootGroup;
    ZFPhotoSet* _photoSet;
    ZFPhoto* _photo;
    ZFMediaType* _mediaType;
}

+ (id) photoIdentifier:(ZFPhoto*) photo 
            mediaType:(ZFMediaType*) mediaType
              photoSet:(ZFPhotoSet*) photoSet 
             rootGroup:(ZFGroup*) rootGroup;

@end
