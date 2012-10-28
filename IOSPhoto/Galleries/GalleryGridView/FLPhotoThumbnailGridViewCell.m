//
//  FLThumbnailGalleryGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoThumbnailGridViewCell.h"
#import "FLGalleryDataModel.h"
#import "FLGridViewController.h"

@implementation FLPhotoThumbnailGridViewCell 

+ (FLPhotoThumbnailGridViewCell*) thumbnailGalleryGridViewCell:(id) obj {
    return FLReturnAutoreleased([[FLPhotoThumbnailGridViewCell alloc] initWithDataRef:obj]);
}

- (Class) viewClassForCellState:(FLGridCellState) state {
    
    switch(state) {
        case FLGridCellStateNormal:
            return [FLPhotoThumbnailGridViewCellView class];
        break;
    }

    return nil;
}

- (UIView*) createViewForGridCellState:(FLGridCellState) state {
    switch(state) {
//        case FLCellViewIDThird:
//        case FLCellViewIDFirst:
//            return [super createViewForGridCellState:visibleViewID];
//        break;
        
        case FLGridCellStateNormal:
            return [super createViewForGridCellState:state];
        break;
    }
    
    return nil;
}

- (void) objectWasTouched:(id) touchedObject {
    [super objectWasTouched:touchedObject];
    
    [touchedObject setSelected:NO];
}

- (void) _showThumbnail:(UIImage*) image
               animated:(BOOL) animated
               finished:(FLFinishedAnimationBlock) finished {
    
    FLPhotoThumbnailGridViewCellView* thumbnail = (FLPhotoThumbnailGridViewCellView*) self.view;
    thumbnail.frame = self.frame;
    thumbnail.image = image;
    thumbnail.hidden = NO;

// TODO: fix thumbail touching

//            thumbnail.thumbnailWidget.userInteractionEnabled = YES;
//            thumbnail.thumbnailWidget.touchHandler = [FLSelectOnTouchUpHandler selectOnTouchUpHandler]; 
//            thumbnail.thumbnailWidget.touchHandler.wasSelectedCallback = FLCallbackMake(self, @selector(touchableObjectWasSelected:));

    if(animated) {
        [thumbnail animateOntoScreen:FLViewAnimationTypeFade 
                            duration:0.15 
                       finishedBlock:^(UIView* view) {
                            finished();
                       }];
    }
    else {
        finished();
    }
}

- (void) cellWillLoad {
    FLGridViewController* controller = self.viewController;
  
    FLAction* loader = [controller.dataModel imageLoaderForGalleryObject:self.cellDataRef
                                                              sizeInView:self.frame.size
                                                                sizeHint:FLGalleryImageSizeHintThumbnail];
    
    [controller startAction:loader completion: ^(id<FLAsyncResult> result) {
        
//            [self setVisibleViewWithViewID:FLCellViewIDSecond withBlock:^(FLFinishedAnimationBlock finished) {
//                [self _showThumbnail:loader.imageResult 
//                            animated:hint == FLAsyncEventHintLoadedFromServer
//                            finished:finished];
//            
//            }];
        
    }];
    
    
    
//
//    if(self.cellDataRef) {
//        [controller.dataModel beginLoadingImageForGalleryObject:self.cellDataRef 
//                                                      sizeInView:self.frame.size 
//                                                        sizeHint:FLGalleryImageSizeHintThumbnail
//                                                    observer:observer];
//    
////        self.cellController.transactionID =  observer.transactionID;
////        if(self.cellController.transactionID) {
////            [self setVisibleViewWithViewID:FLCellViewIDFirst];
////        }
//    }

}


@end






