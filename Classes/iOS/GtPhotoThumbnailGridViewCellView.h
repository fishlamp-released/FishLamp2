//
//  GtGalleryThumbnailView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWidgetView.h"
#import "GtImageFrameWidget.h"

@interface GtPhotoThumbnailGridViewCellView : GtWidgetView {
@private
    GtImageFrameWidget* m_galleryThumbnail;
}

@property (readonly, retain, nonatomic) GtImageFrameWidget* thumbnailWidget;

@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

@end
