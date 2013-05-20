//
//  GtGalleryGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/1/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGalleryGridViewController.h"
#import "GtDataProviderPhotoViewController.h"
#import "GtGradientView.h"

@implementation GtGalleryGridViewController

@synthesize galleryContainer = m_galleryContainer;
@synthesize galleryID = m_galleryID;

- (void) dealloc
{   
    GtRelease(m_galleryID);
    GtRelease(m_galleryContainer);
    GtSuperDealloc();
}

- (void) setGalleryID:(id) galleryID
{
    if(GtAssignObject(m_galleryID, galleryID))
    {
        GtReleaseWithNil(m_galleryContainer);
    }
}

- (void) setGalleryContainer:(id) galleryContainer
{
    if(GtAssignObject(m_galleryContainer, galleryContainer))
    {
       GtAssignObject(m_galleryID, [m_galleryContainer gridViewObjectID]);
       [self setTitleWithGalleryContainer];
    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self createTopToolbar];
}

- (void) setTitleWithGalleryContainer
{
    self.title = [m_galleryContainer gridViewDisplayName];
}

- (void) beginLoadingPageAtIndex:(NSInteger) startingIndex
{
    GtAsyncEventHandler* handler = [GtAsyncEventHandler asyncEventHandler:self.actionContext];
    handler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
        if(!error)
        {
            GtAssertIsExpectedType(data, NSArray);
            [self.cellCollection addOrReplaceCellsWithGridViewObjects:data atIndex:startingIndex];
            [self reflowCells];
        }
        [self setFinishedRefreshing];
    };

    [self.dataProvider beginLoadingChildrenForGallery:self.galleryContainer 
        startingIndex:startingIndex 
        eventHandler:handler];
}  

- (void) beginLoadingCurrentPage
{
    if(!self.visibleCellCollection.count)
    {
        [self beginLoadingPageAtIndex:0];
    }
    else
    {
        GtVisibleCellRanges visible = self.visibleCellCollection.visibleRanges;
    
        GtAssert(visible.count == 1, @"only expecting one range here");
    
        [self beginLoadingPageAtIndex:visible.ranges[0].location];
    }
}

- (void) beginLoadingGalleryContainer
{
    GtAsyncEventHandler* handler = [GtAsyncEventHandler asyncEventHandler:self.actionContext];
    handler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
        if(!error)
        {
            self.galleryContainer = data;
        }
    };
    
    handler.didCompleteBlock = ^(NSError* error) {
        if(!error)
        {
            [self beginLoadingCurrentPage];
        }
        else
        {
            [self setFinishedRefreshing];
        }
    };

    [self.dataProvider beginLoadingGalleryContainerByID:self.galleryID eventHandler:handler];
}                                                             

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
    [self beginLoadingGalleryContainer];
    
    [super beginRefreshing:userRequestedRefresh];
}

- (void) lastCellIsVisible
{
    if(self.dataProvider)
    {   
        if([self.galleryContainer subItemCount] && ([self.galleryContainer subItemCount] > self.cellCollection.count))
        {
            GtVisibleCellRanges visible = self.visibleCellCollection.visibleRanges;
    
            GtAssert(visible.count == 1, @"only expecting one range here");
    
            [self beginLoadingPageAtIndex:GtRangeLastIndex(visible.ranges[0]) + 1];
        }
    }
}

- (GtViewContentsDescriptor) describeViewContents
{
	GtViewContentsDescriptor contents = GtViewContentsDescriptorNone;
	contents.top = GtViewContentItemToolbarAndStatusBar;
    return contents;
}

- (NSUInteger) numPagesLoaded
{
    return ceilf(((float)self.cellCollection.count) / ((float)[self.dataProvider pageSize]));
}

@end
