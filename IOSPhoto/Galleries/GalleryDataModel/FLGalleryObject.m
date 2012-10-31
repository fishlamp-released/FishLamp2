//
//  FLGalleryObject.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLGalleryObject.h"

@implementation FLGalleryObject

//@synthesize dataRefKey = _dataRefKey;
@synthesize gridViewDisplayName = _title;
@synthesize ownerID = _ownerID;
@synthesize parentID = _parentID;
@synthesize galleryItemType = _galleryItemType;
@synthesize subItemCount = _subItemCount;
@synthesize objectID = _objectID;

//- (id) dataRefValue {
//    return self;
//}
//
//- (void) setDataRefValue:(id) value {
//    FLAssertFailed_v(@"can't set data ref value here");
//}
//

- (id) initWithObjectID:(id) objectID {
    self = [super init];
    if(self) {
        self.objectID = objectID;
    }
    
    return self;
}

+ (id) galleryObject:(id) objectID {
    return autorelease_([[[self class] alloc] initWithObjectID:objectID]);
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_dataRefKey);
    mrc_release_(_title);
    mrc_release_(_ownerID);
    mrc_release_(_parentID);
    [_objectID release];
    mrc_super_dealloc_();
}
#endif

//- (FLGridCell*) createGridViewCell {
//    return nil;
//}

//- (id<FLGridCellSelectionHandler>) createGridViewSelectionHandler {
//    return nil;
//}
//
//- (id<FLGridCellTouchHandler>)createGridViewTouchHandler {
//    return nil;
//}


@end