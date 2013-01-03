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

@synthesize thumbnailWidget = _galleryThumbnail;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
        
        _galleryThumbnail = [[FLImageFrameWidget alloc] init];
		_galleryThumbnail.imageWidget = [FLImageWidget widget];
        _galleryThumbnail.frameOptimizedForSize = self.frame;
        _galleryThumbnail.hidden = NO;
        _galleryThumbnail.showFrame = YES;
        _galleryThumbnail.showStack = NO;

// TODO: not sure about content mode here.
//        _galleryThumbnail.contentMode = FLWidgetContentModeScaleAspectFit;

        _galleryThumbnail.imageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFit;
        [self.rootWidget addWidget:_galleryThumbnail];
    }
    
    return self;
}

- (void) setHighlighted:(BOOL) highlighted
{
    _galleryThumbnail.highlighted = highlighted;
}

- (BOOL) isHighlighted
{
    return _galleryThumbnail.isHighlighted;
}

- (void) setImage:(UIImage*) image
{
    _galleryThumbnail.imageWidget.image = image;
    [self setNeedsLayout];
}

- (UIImage*) image
{
    return _galleryThumbnail.imageWidget.image;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _galleryThumbnail.frame = CGRectInset(self.bounds, 10, 10);
    [_galleryThumbnail setNeedsLayout];
}

- (void) dealloc
{
	FLRelease(_galleryThumbnail);
    FLSuperDealloc();
}

- (void) wasCachedInCache:(FLObjectCache*) cache
{
    self.highlighted = NO;
    _galleryThumbnail.imageWidget.image = nil;
    [super wasCachedInCache:cache];
}

@end
