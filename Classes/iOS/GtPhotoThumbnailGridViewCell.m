//
//  GtThumbnailGalleryGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoThumbnailGridViewCell.h"
#import "GtGalleryDataProvider.h"
#import "GtGridViewCellHighlightTouchHandler.h"

@implementation GtPhotoThumbnailGridViewCell

+ (GtPhotoThumbnailGridViewCell*) thumbnailGalleryGridViewCell:(id) obj
{
    return GtReturnAutoreleased([[GtPhotoThumbnailGridViewCell alloc] initWithGridViewObject:obj]);
}

- (id) initWithGridViewObject:(id) obj
{
    if((self = [super initWithGridViewObject:obj]))
    {
    }
    
    return self;
}

- (BOOL) touchPointSelectsCell:(CGPoint) point
{
    if(self.displayState == GtGridViewCellDisplayStateSecond)
    {
        GtPhotoThumbnailGridViewCellView* thumbnail = (GtPhotoThumbnailGridViewCellView*) self.view;
        return CGRectContainsPoint(thumbnail.thumbnailWidget.imageWidget.frame, [thumbnail convertPoint:point fromView:thumbnail.superview]);
    }
        
    return NO;
}

- (void) cellHighlightedStateDidChange
{   
    if(self.displayState == GtGridViewCellDisplayStateSecond)
    {
        GtPhotoThumbnailGridViewCellView* thumbnail = (GtPhotoThumbnailGridViewCellView*) self.view;
        [thumbnail setHighlighted:self.isHighlighted];
    }
}                    

- (void) layoutSubviews
{
    switch(self.displayState)
    {
        case GtGridViewCellDisplayStateFirst:
            self.view.frameOptimizedForLocation =  GtRectCenterRectInRect(self.frame, self.view.frame);
        break;
        
        case GtGridViewCellDisplayStateSecond:
            self.view.frameOptimizedForLocation = self.frame;
        break;
        
        case GtGridViewCellDisplayStateThird:
        break;
    }
}

- (UIView*) createViewForDisplayState:(GtGridViewCellDisplayState) displayState
{
    switch(displayState)
    {
        case GtGridViewCellDisplayStateFirst:
            return GtReturnAutoreleased([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]);
        break;
        
        case GtGridViewCellDisplayStateSecond:
            return GtReturnAutoreleased([[GtPhotoThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
        break;

        case GtGridViewCellDisplayStateThird:
        break;
    }
    
    return nil;
}

- (void) cellWillChangeStateAnimated:(BOOL) animated
                            data:(id) dataOrNil
              completionCallback:(GtBlock) completionCallback;
{
    switch(self.displayState)
    {
        case GtGridViewCellDisplayStateFirst:
        {
            UIActivityIndicatorView* progress = (UIActivityIndicatorView*) self.view;
            progress.frame = GtRectCenterRectInRect(self.frame, progress.frame);
            progress.hidden = NO;
            [progress startAnimating];
            completionCallback();
        }
        break;
        
        case GtGridViewCellDisplayStateSecond:
        {
            GtAssertIsExpectedType(dataOrNil, UIImage);
            
            GtPhotoThumbnailGridViewCellView* thumbnail = (GtPhotoThumbnailGridViewCellView*) self.view;
            thumbnail.frame = self.frame;
            thumbnail.image = dataOrNil;
            thumbnail.hidden = NO;
            
            if(animated)
            {
                [thumbnail animateOntoScreen:GtViewAnimationTypeFade duration:0.15 
                               finishedBlock:completionCallback];
            }
            else
            {
                completionCallback();
            }
        }
        break;
    
        case GtGridViewCellDisplayStateThird:
        break;
    }
}

- (void) cellWillLoad
{
    GtGridViewController* controller = self.viewController;
          
    GtAsyncEventHandler* handler = [GtAsyncEventHandler asyncEventHandler:controller.actionContext];
    
    handler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
        if(!error)
        {
            GtAssertIsExpectedType(data, [UIImage class]);
        
            [self beginChangingDisplayStateTo:GtGridViewCellDisplayStateSecond 
                withData:data 
                animated:result == GtAsyncEventHandlerResultLoadedFromServer];
        }
    };
    
    handler.didCompleteBlock = ^(NSError* error){
        self.transactionID = nil;
        }; 

    if(self.gridViewObject) 
    {
        [controller.dataProvider beginLoadingImageForGalleryObject:self.gridViewObject sizeInView:self.frame.size sizeHint:GtGalleryImageSizeHintThumbnail
        eventHandler:handler];
    
        self.transactionID =  handler.transactionID;
        if(self.transactionID)
        {
            [self beginChangingDisplayStateTo:GtGridViewCellDisplayStateFirst withData:nil animated:NO];
        }
    }

}


//- (void) cellWillAppearInSuperview:(UIView*) superview 
//                    viewController:(GtGridViewController*) controller
//{
//
//    id<GtGalleryObject> galleryItem = self.gridViewObject;
//          
//    GtAsyncEventHandler* handler = [GtAsyncEventHandler asyncEventHandler:controller.actionContext];
//    
//    handler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
//        [controller.objectCache cacheObject:&m_progress reuseIdentifier:@"progress"];
//        if(!error)
//        {
//            [self showThumbnail:superview viewController:controller image:data animated:result == GtAsyncEventHandlerResultLoadedFromServer];
//        }
//    };
//    
//    handler.didCompleteBlock = ^(NSError* error){
//        self.transactionID = nil;
//        }; 
//
//    if(galleryItem) 
//    {
//        [controller.dataProvider beginLoadingImageForGalleryObject:galleryItem sizeInView:self.frame.size sizeHint:GtGalleryImageSizeHintThumbnail
//        eventHandler:handler];
//    
//        self.transactionID =  handler.transactionID;
//        if(self.transactionID)
//        {
//            [self showProgress:superview viewController:controller];
//            [controller.objectCache cacheObject:&m_thumbnail reuseIdentifier:@"thumb"];
//        }
//    }
//    [super cellWillAppearInSuperview:superview viewController:controller];
//}

//- (void) cellDidDisappearFromSuperview:(UIView*) superview  
//                            viewController:(GtGridViewController*) controller
//{
//    [controller.objectCache cacheObject:&m_progress reuseIdentifier:@"progress"];
//    [controller.objectCache cacheObject:&m_thumbnail reuseIdentifier:@"thumb"];
//    [super cellDidDisappearFromSuperview:superview viewController:controller];
//}

@end






