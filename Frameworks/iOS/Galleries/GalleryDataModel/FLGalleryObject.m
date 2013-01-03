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
    return FLAutorelease([[[self class] alloc] initWithObjectID:objectID]);
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_dataRefKey);
    FLRelease(_title);
    FLRelease(_ownerID);
    FLRelease(_parentID);
    [_objectID release];
    FLSuperDealloc();
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