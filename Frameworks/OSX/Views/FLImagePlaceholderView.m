//
//  FLImagePlaceholderView.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLImagePlaceholderView.h"

@interface FLImagePlaceholderView ()
@property (readwrite, assign, nonatomic) CGFloat borderWidth;
@end

@implementation FLImagePlaceholderView
@synthesize imageView = _imageView;
@synthesize borderWidth = _borderWidth;
@synthesize alwaysProportionallyResize = _alwaysProportionallyResize;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = NO;
        
        _alwaysProportionallyResize = YES;
        _borderWidth = 4.0;
        self.autoresizesSubviews = NO;
        
//        self.backgroundColor = [NSColor gray95Color];
        _progress = [[FLSpinningProgressView alloc] initWithFrame:CGRectMake(0,0,20,20)];
        _progress.frame = FLRectCenterRectInRect(self.bounds, _progress.frame);
        
        [self addSubview:_progress];
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    _imageView.imageAlignment = NSImageAlignCenter;
    _imageView.imageScaling = NSImageScaleProportionallyDown;
    _imageView.imageFrameStyle = NSImageFrameNone;
    _imageView.hidden = YES;
}

#if FL_MRC
- (void) dealloc {
    [_progress release];
    [super dealloc];
}
#endif

- (void) setFrame:(CGRect) frame {
    [super setFrame:frame];
    
    _progress.frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.bounds, _progress.frame));
    _imageView.frame = CGRectMake(_borderWidth, _borderWidth, self.bounds.size.width - (_borderWidth*2), self.bounds.size.height - (_borderWidth*2));
}

- (void) resizeToProportionalImageSize {
    if(_imageView.image) {
        CGRect frame = CGRectInset(self.superview.bounds, _borderWidth, _borderWidth);
        frame = FLRectFitInRectInRectProportionally(frame,CGRectMake(0,0,_imageView.image.size.width, _imageView.image.size.height));
        frame.size.width += (_borderWidth*2);
        frame.size.height += (_borderWidth*2);
        frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.superview.bounds, frame));

    // image view frame is set in self setFrame
        self.frame = frame;
    }
}

- (void) startAnimating {
    [_progress startAnimating];
    _imageView.hidden = YES;
}

- (void) stopAnimating {
    [_progress stopAnimating];
    _imageView.hidden = NO;
}

- (void) didMoveToSuperview {
    if(self.superview) {
        self.frame = self.superview.bounds;
    }
}

- (void) setImage:(NSImage*) image {
    
    _imageView.image = image;
    if(image) {
        [self stopAnimating];
        _imageView.hidden = NO;    
        
        if(_alwaysProportionallyResize) {
            [self resizeToProportionalImageSize];
        }
    }
    else {
        _imageView.hidden = YES;
        [self startAnimating];
    }
}

- (void) removeImage {
    _imageView.image = nil;
    _imageView.hidden = YES;
}

@end
