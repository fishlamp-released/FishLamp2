//
//  FLGalleryThumbnailView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLWidgetView.h"
#import "FLImageFrameWidget.h"

@interface FLPhotoThumbnailGridViewCellView : FLWidgetView {
@private
    FLImageFrameWidget* m_galleryThumbnail;
}

@property (readonly, retain, nonatomic) FLImageFrameWidget* thumbnailWidget;

@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

@end
