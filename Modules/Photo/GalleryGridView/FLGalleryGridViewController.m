//
//  FLGalleryGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/1/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryGridViewController.h"
#import "FLDataProviderPhotoViewController.h"
#import "FLGradientView.h"
#import "FLToolbarView.h"
#import "FLToolbarTitleView.h"

@implementation FLGalleryGridViewController

@synthesize galleryContainer = m_galleryContainer;
@synthesize galleryID = m_galleryID;

- (void) dealloc
{   
    FLRelease(m_galleryID);
    FLRelease(m_galleryContainer);
    FLSuperDealloc();
}

- (void) setGalleryID:(id) galleryID
{
    if(m_galleryID != galleryID)
    {
        FLAssignObject(m_galleryID, galleryID);
        FLReleaseWithNil(m_galleryContainer);
    }
}

- (void) setGalleryContainer:(id) galleryContainer
{
    if(m_galleryContainer != galleryContainer)
    {   
        FLAssignObject(m_galleryContainer, galleryContainer);
        FLAssignObject(m_galleryID, [m_galleryContainer gridViewObjectId]);
        [self setTitleWithGalleryContainer];
    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    FLToolbarView* toolbar = [FLToolbarView toolbarView];
    [toolbar.centerItems addToolbarItem:[FLToolbarTitleView toolbarTitleView]];
    [toolbar addBackgroundGradientView];
    self.topBarView = toolbar;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    self.topBarView = nil;
}

- (void) setTitleWithGalleryContainer
{
    self.title = [m_galleryContainer gridViewDisplayName];
}

- (void) beginLoadingPageAtIndex:(NSInteger) startingIndex
{
    FLAsyncEventHandler* handler = [FLAsyncEventHandler asyncEventHandler:self.actionContext];
    handler.onEvent = ^(FLAsyncEventHandler* theHandler, BOOL success, id result, FLAsyncEventHint hint) {
        if(success) {
            [self addOrReplaceGridViewObjects:result];
        }
    
    };
    
    handler.onFinished = ^(FLAsyncEventHandler* theHandler) {
//        if(!theHandler.lastEventResult.error) {
//            [self addOrReplaceGridViewObjects:theHandler.lastEventResult.eventOutput];
//        }
        
        [self setFinishedRefreshing];
    };

    [self.dataSource beginLoadingChildrenForGallery:self.galleryContainer 
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
        FLVisibleCellRanges visible = self.visibleCellCollection.visibleRanges;
    
        FLAssert(visible.count == 1, @"only expecting one range here");
    
        [self beginLoadingPageAtIndex:visible.ranges[0].location];
    }
}

- (void) beginLoadingGalleryContainer
{
    FLAsyncEventHandler* handler = [FLAsyncEventHandler asyncEventHandler:self.actionContext];
    handler.onEvent = ^(FLAsyncEventHandler* theHandler,  BOOL success, id result, FLAsyncEventHint hint) {
        if(success) {
            self.galleryContainer = result;
            [self beginLoadingCurrentPage];
        }
        
        // TODO: handle error?
    };
    
    handler.onFinished = ^(FLAsyncEventHandler* theHandler) {
        [self setFinishedRefreshing];
    };

    [self.dataSource beginLoadingGalleryContainerByID:self.galleryID eventHandler:handler];
}                                                             

- (void) beginRefreshing:(BOOL) userRequestedRefresh
{
    [self beginLoadingGalleryContainer];
    
    [super beginRefreshing:userRequestedRefresh];
}

- (void) lastCellIsVisible
{
    if(self.dataSource)
    {   
        if([self.galleryContainer subItemCount] && ([self.galleryContainer subItemCount] > self.cellCollection.count))
        {
            FLVisibleCellRanges visible = self.visibleCellCollection.visibleRanges;
    
            FLAssert(visible.count == 1, @"only expecting one range here");
    
            [self beginLoadingPageAtIndex:FLRangeLastIndex(visible.ranges[0]) + 1];
        }
    }
}

- (NSUInteger) numPagesLoaded
{
    return ceilf(((float)self.cellCollection.count) / ((float)[self.dataSource pageSize]));
}

@end
