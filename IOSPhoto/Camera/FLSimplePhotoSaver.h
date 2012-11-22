//
//  FLSimplePhotoSaver.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAction.h"
#import "FLSimplePhoto.h"
#import "FLJpegFileImageAsset.h"
#import "FLFolder.h"

@interface FLSimplePhotoSaver : FLAction {
@private
    FLSimplePhoto* _photo;
    FLJpegFileImageAsset* _savedImageAsset;
}

@property (readonly, strong) FLSimplePhoto* simplePhoto;
@property (readonly, strong) id<FLImageAsset> savedImageAsset;

// [FLUserSession instance].photoFolder
- (id) initWithSimplePhoto:(FLSimplePhoto*) photo
              saveInFolder:(FLFolder*) folder;

+ (FLSimplePhotoSaver*) simplePhotoSaver:(FLSimplePhoto*) photo
                            saveInFolder:(FLFolder*) folder;

@end