//
//  FLThumbnailGalleryGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoThumbnailGridViewCell.h"
#import "FLGalleryDataProvider.h"

@implementation FLPhotoThumbnailGridViewCell 

+ (FLPhotoThumbnailGridViewCell*) thumbnailGalleryGridViewCell:(id) obj {
    return FLReturnAutoreleased([[FLPhotoThumbnailGridViewCell alloc] initWithGridViewObject:obj]);
}

- (id) initWithGridViewObject:(id) obj
{
    if((self = [super initWithGridViewObject:obj])) {
    }
    
    return self;
}

- (UIView*) createViewForVisibleView:(FLGridViewCellVisibleView) visibleView
{
    switch(visibleView) {
        case FLGridViewCellVisibleViewThird:
        case FLGridViewCellVisibleViewFirst:
            return [super createViewForVisibleView:visibleView];
        break;
        
        case FLGridViewCellVisibleViewSecond:
            return FLReturnAutoreleased([[FLPhotoThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
        break;
    }
    
    return nil;
}

- (void) gridViewCellView:(UIView*) view objectWasTouched:(id) touchedObject
{
    [super gridViewCellView:view objectWasTouched:touchedObject];
    
    [touchedObject setSelected:NO];
}

- (void) _showThumbnail:(UIImage*) image
               animated:(BOOL) animated
{
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
                            [self finishChangingVisibleView];
                       }];
    }
    else {
        [self finishChangingVisibleView];
    }
}

- (void) cellWillLoad
{
    FLGridViewController* controller = self.viewController;
          
    FLAsyncEventHandler* handler = [FLAsyncEventHandler asyncEventHandler:controller.actionContext];
    
    handler.onEvent = ^(FLAsyncEventHandler* theHandler, BOOL success, id result, FLAsyncEventHint hint) {
        if(success) {
            FLAssertIsType(result, [UIImage class]);
            
            [self setVisibleView:FLGridViewCellVisibleViewSecond withBlock:^() {
                [self _showThumbnail:result 
                            animated:hint == FLAsyncEventHintLoadedFromServer];
            
            }];
        }
    };
    
    handler.onFinished = ^(FLAsyncEventHandler* theHandler){
        self.transactionID = nil;
        }; 

    if(self.gridViewObject) {
        [controller.dataSource beginLoadingImageForGalleryObject:self.gridViewObject 
                                                      sizeInView:self.frame.size 
                                                        sizeHint:FLGalleryImageSizeHintThumbnail
                                                    eventHandler:handler];
    
        self.transactionID =  handler.transactionID;
        if(self.transactionID) {
            [self setVisibleView:FLGridViewCellVisibleViewFirst];
        }
    }

}


@end






