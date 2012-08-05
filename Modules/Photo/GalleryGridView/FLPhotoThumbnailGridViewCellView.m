//
//  FLGalleryThumbnailView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoThumbnailGridViewCellView.h"
#import "FLImageWidget.h"
#import "FLObjectCache.h"

@implementation FLPhotoThumbnailGridViewCellView

@synthesize thumbnailWidget = m_galleryThumbnail;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
        
        m_galleryThumbnail = [[FLImageFrameWidget alloc] init];
		m_galleryThumbnail.imageWidget = [FLImageWidget widget];
        m_galleryThumbnail.frameOptimizedForSize = self.frame;
        m_galleryThumbnail.hidden = NO;
        m_galleryThumbnail.showFrame = YES;
        m_galleryThumbnail.showStack = NO;

// TODO: not sure about content mode here.
//        m_galleryThumbnail.contentMode = FLWidgetContentModeScaleAspectFit;

        m_galleryThumbnail.imageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
        [self.rootWidget addWidget:m_galleryThumbnail];
    }
    
    return self;
}

- (void) setHighlighted:(BOOL) highlighted
{
    m_galleryThumbnail.highlighted = highlighted;
}

- (BOOL) isHighlighted
{
    return m_galleryThumbnail.isHighlighted;
}

- (void) setImage:(UIImage*) image
{
    m_galleryThumbnail.imageWidget.image = image;
    [self setNeedsLayout];
}

- (UIImage*) image
{
    return m_galleryThumbnail.imageWidget.image;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    m_galleryThumbnail.frame = CGRectInset(self.bounds, 10, 10);
    [m_galleryThumbnail setNeedsLayout];
}

- (void) dealloc
{
	FLRelease(m_galleryThumbnail);
    FLSuperDealloc();
}

- (void) objectCacheWillCacheObject:(FLObjectCache*) cache
{
    self.highlighted = NO;
    m_galleryThumbnail.imageWidget.image = nil;
    [super objectCacheWillCacheObject:cache];
}

@end
