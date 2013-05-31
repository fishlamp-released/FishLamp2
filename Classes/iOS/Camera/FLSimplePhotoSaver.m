//
//  FLSimplePhotoSaver.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimplePhotoSaver.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "NSString+GUID.h"
#import "FLSaveImageAssetToStorageOperation.h"

@interface FLSimplePhotoSaver ()
@property (readwrite, strong) FLSimplePhoto* simplePhoto;
@end

@implementation FLSimplePhotoSaver

@synthesize simplePhoto = _simplePhoto;
@synthesize savedImageAsset = _savedImageAsset;

- (id) initWithSimplePhoto:(FLSimplePhoto*) photo
              saveInFolder:(FLFolder*) folder {
    
    self = [super init];
    if(self) {

        self.simplePhoto = photo;

        FLProgressViewController* progress =
            [FLProgressViewController progressViewController:[FLSimpleProgressView class]
                                        presentationBehavior:[FLModalPresentationBehavior instance]];
        
        progress.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalCentered, FLRectLayoutVerticalBottomThird);
        progress.viewContentsDescriptor = [FLViewContentsDescriptor viewContentsDescriptorWithTop:FLViewContentItemToolbar bottom:FLViewContentItemNone hasStatusBar:NO];
        self.progressController = progress;

        self.actionDescription.actionType = FLActionDescriptionTypeSave;
        self.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;

        _savedImageAsset = [[FLJpegFileImageAsset alloc] initWithFolder:folder assetUID:[NSString guidString]];

        [_savedImageAsset.original setImage:photo.image exifData:photo.exif];

        [self addOperation:[FLSaveImageAssetToStorageOperation saveImageAssetToStorageOperation:_savedImageAsset wantsThumbnail:YES]];
    }
    
    return self;
}

+ (FLSimplePhotoSaver*) simplePhotoSaver:(FLSimplePhoto*) photo
                            saveInFolder:(FLFolder*) folder {
    return FLAutorelease([[FLSimplePhotoSaver alloc] initWithSimplePhoto:photo saveInFolder:folder]);
}


#if FL_MRC
- (void) dealloc {
    [_savedImageAsset release];
    [_simplePhoto release];
    [super dealloc];
}
#endif


@end