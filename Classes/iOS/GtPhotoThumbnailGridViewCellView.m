//
//  GtGalleryThumbnailView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoThumbnailGridViewCellView.h"
#import "GtImageWidget.h"
#import "GtObjectCache.h"

@implementation GtPhotoThumbnailGridViewCellView

@synthesize thumbnailWidget = m_galleryThumbnail;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        m_galleryThumbnail = [[GtImageFrameWidget alloc] init];
		m_galleryThumbnail.imageWidget = [GtImageWidget widget];
        m_galleryThumbnail.frameOptimizedForSize = self.frame;
        m_galleryThumbnail.hidden = NO;
        m_galleryThumbnail.showFrame = YES;
        m_galleryThumbnail.showStack = NO;
        m_galleryThumbnail.contentMode = GtWidgetContentModeScaleAspectFit;
        m_galleryThumbnail.imageWidget.contentMode = GtWidgetContentModeScaleAspectFit;
        [self addWidget:m_galleryThumbnail];
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

- (void) drawRect:(CGRect) rect
{
    [super drawRect:rect];
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.backgroundColor setFill];
    CGContextFillRect(context, rect);    
    [m_galleryThumbnail drawRect:rect];
    CGContextRestoreGState(context);
}

- (void) dealloc
{
	GtRelease(m_galleryThumbnail);

    GtSuperDealloc();
}

- (void) objectCacheWillCacheObject:(GtObjectCache*) cache
{
    self.highlighted = NO;
    m_galleryThumbnail.imageWidget.image = nil;
    [super objectCacheWillCacheObject:cache];
}

@end
