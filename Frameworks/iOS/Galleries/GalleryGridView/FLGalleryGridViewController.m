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

@synthesize galleryContainer = _galleryContainer;
@synthesize galleryID = _galleryID;

- (void) dealloc
{   
    FLRelease(_galleryID);
    FLRelease(_galleryContainer);
    FLSuperDealloc();
}

- (void) setGalleryID:(id) galleryID
{
    if(_galleryID != galleryID)
    {
        FLSetObjectWithRetain(_galleryID, galleryID);
        FLReleaseWithNil(_galleryContainer);
    }
}

- (void) setGalleryContainer:(id) galleryContainer
{
    if(_galleryContainer != galleryContainer)
    {   
        FLSetObjectWithRetain(_galleryContainer, galleryContainer);
        FLSetObjectWithRetain(_galleryID, [_galleryContainer dataRefKey]);
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
    self.title = [_galleryContainer gridViewDisplayName];
}

- (void) beginLoadingPageAtIndex:(NSInteger) startingIndex {
/*
    FLAsyncJob* job = [FLAsyncJob asyncJobWithContext:self.actionContext];
    job.observer = ^(FLAsyncJob* inJob, FLAsyncJobUpdate* result) {
        
        inJob.onMainThread = ^{
        
            switch(result.jobState) {
                case FLAsyncJobStageStarted:
                break;
                
                case FLAsyncJobStageWorking:
                    [self addOrReplaceCellDataRefs: result.data];
                break;
                
                case FLAsyncJobStageError:
                break;
                
                case FLAsyncJobStageFinished:
                    [self setFinishedRefreshing];
                break;
            }
        };
        
    
    };
*/    

    FLAction* loader = [self.dataModel childrenLoaderForGallery:self.galleryContainer
        startingIndex:startingIndex];
    
    [self startAction:loader completion:^(id result){
        if(loader.didSucceed) {
            [self addOrReplaceCellDataRefs:loader.loadChildrenResult];
        }
        
        [self setFinishedRefreshing];
    }];
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
    
        FLAssertWithComment(visible.count == 1, @"only expecting one range here");
    
        [self beginLoadingPageAtIndex:visible.ranges[0].location];
    }
}

- (void) beginLoadingGalleryContainer {


    FLAction* loader = [self.dataModel galleryLoaderWithGalleryID:self.galleryID];
    
    [self startAction:loader completion: ^(id result) {
        [self setFinishedRefreshing];
        if(loader.didSucceed) {
            self.galleryContainer = loader.loadGalleryResult;
            [self beginLoadingCurrentPage];
        }
    }];
    
    
//    
//    [FLAsyncJob asyncJobWithContext:self.actionContext];
//    job.observer = ^(FLAsyncJob* inJob,  FLAsyncJobUpdate* result) {
//        
//        inJob.onMainThread = ^{
//            switch(result.jobState) {
//                case FLAsyncJobStageStarted:
//                break;
//                
//                case FLAsyncJobStageWorking:
//                break;
//                
//                case FLAsyncJobStageError:
//                    // TODO: handle error?
//                break;
//     
//                case FLAsyncJobStageFinished:
//                break;
//            }
//        };
//        
//    };
//    
//     observer:job];
}

- (void) beginRefreshing:(BOOL) userRequestedRefresh {
    [self beginLoadingGalleryContainer];
    
    [super beginRefreshing:userRequestedRefresh];
}

- (void) lastCellIsVisible {
    if(self.dataModel) {   
        if([self.galleryContainer subItemCount] && ([self.galleryContainer subItemCount] > self.cellCollection.count)) {
            FLVisibleCellRanges visible = self.visibleCellCollection.visibleRanges;
    
            FLAssertWithComment(visible.count == 1, @"only expecting one range here");
    
            [self beginLoadingPageAtIndex:FLRangeLastIndex(visible.ranges[0]) + 1];
        }
    }
}

- (NSUInteger) numPagesLoaded {
    return ceilf(((float)self.cellCollection.count) / ((float)[self.dataModel pageSize]));
}

@end
