//
//  FLCropImageView.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCropImageView.h"
#import "UIImage+Resize.h"
#import "UIImageView+FLViewGeometry.h"

@implementation FLCropImageView

- (id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        self.autoresizesSubviews = NO;
        self.backgroundColor = [UIColor blackColor];
    
        m_imageView = [[UIImageView alloc] initWithFrame:frame];
        m_imageView.contentMode = UIViewContentModeScaleAspectFit;
        m_imageView.autoresizesSubviews = NO;
        m_imageView.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:m_imageView];
    }
    
    return self;
}

- (void) dealloc
{
    FLRelease(m_imageView);
    FLSuperDealloc();
}

- (void) setImage:(UIImage*) image
{
    m_imageView.image = image;
    [self setNeedsLayout];
}

- (UIImage*) image
{
    return m_imageView.image;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [m_imageView resizeProportionally:self.bounds.size];
    m_imageView.frameOptimizedForLocation = FLRectCenterRectInRect(self.bounds, m_imageView.frame);
}

@end
