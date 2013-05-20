//
//  GtGalleryDataSource.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGalleryDataProvider.h"

@implementation GtGalleryObject

@synthesize gridViewObjectID = m_gridViewObjectID;
@synthesize gridViewDisplayName = m_title;
@synthesize ownerID = m_ownerID;
@synthesize parentID = m_parentID;
@synthesize galleryItemType = m_galleryItemType;
@synthesize subItemCount = m_subItemCount;

- (id) initWithGridViewDataID:(id) gridViewObjectID;
{
    if((self = [super init]))
    {
        self.gridViewObjectID = gridViewObjectID;
    }
    
    return self;
}

+ (id) galleryItem:(id) gridViewObjectID
{
    return GtReturnAutoreleased([[[self class] alloc] initWithGridViewDataID:gridViewObjectID]);
}

- (void) dealloc
{
    GtRelease(m_gridViewObjectID);
    GtRelease(m_title);
    GtRelease(m_ownerID);
    GtRelease(m_parentID);
    GtSuperDealloc();
}

- (GtGridViewCellController*) createGridViewCell
{
    return nil;
}

- (id<GtGridViewCellSelectionHandler>) createGridViewSelectionHandler
{
    return nil;
}
- (id<GtGridViewCellTouchHandler>)createGridViewTouchHandler
{
    return nil;
}


@end