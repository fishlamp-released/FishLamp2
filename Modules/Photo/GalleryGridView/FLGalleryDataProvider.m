//
//  FLGalleryDataSource.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryDataProvider.h"

@implementation FLGalleryObject

@synthesize gridViewObjectId = m_gridViewObjectId;
@synthesize gridViewDisplayName = m_title;
@synthesize ownerID = m_ownerID;
@synthesize parentID = m_parentID;
@synthesize galleryItemType = m_galleryItemType;
@synthesize subItemCount = m_subItemCount;

- (id) initWithGridViewDataID:(id) gridViewObjectId;
{
    if((self = [super init]))
    {
        self.gridViewObjectId = gridViewObjectId;
    }
    
    return self;
}

+ (id) galleryItem:(id) gridViewObjectId
{
    return FLReturnAutoreleased([[[self class] alloc] initWithGridViewDataID:gridViewObjectId]);
}

- (void) dealloc
{
    FLRelease(m_gridViewObjectId);
    FLRelease(m_title);
    FLRelease(m_ownerID);
    FLRelease(m_parentID);
    FLSuperDealloc();
}

- (FLGridViewCell*) createGridViewCell
{
    return nil;
}

- (id<FLGridViewCellSelectionHandler>) createGridViewSelectionHandler
{
    return nil;
}
- (id<FLGridViewCellTouchHandler>)createGridViewTouchHandler
{
    return nil;
}


@end