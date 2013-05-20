//
//  FLCropImageView.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
    
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizesSubviews = NO;
        _imageView.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:_imageView];
    }
    
    return self;
}

- (void) dealloc
{
    FLRelease(_imageView);
    FLSuperDealloc();
}

- (void) setImage:(UIImage*) image
{
    _imageView.image = image;
    [self setNeedsLayout];
}

- (UIImage*) image
{
    return _imageView.image;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [_imageView resizeProportionally:self.bounds.size];
    _imageView.frameOptimizedForLocation = FLRectCenterRectInRect(self.bounds, _imageView.frame);
}

@end
