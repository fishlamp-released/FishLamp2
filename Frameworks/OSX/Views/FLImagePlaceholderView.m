//
//  FLImagePlaceholderView.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLImagePlaceholderView.h"

@interface FLImagePlaceholderView ()
@property (readwrite, strong, nonatomic) NSString* loadingPath;
@end

@implementation FLImagePlaceholderView

@synthesize imageView = _imageView;
@synthesize frameSize = _frameSize;
@synthesize loadingPath = _loadingPath;

@synthesize alwaysProportionallyResize = _alwaysProportionallyResize;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = NO;
        
        _alwaysProportionallyResize = YES;
        _frameSize = 4.0;
        
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
    [_loadingPath release];
    [_progress release];
    [super dealloc];
}
#endif

- (void) setFrame:(CGRect) frame {
    [super setFrame:frame];
    
    _progress.frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.bounds, _progress.frame));
    _imageView.frame = CGRectMake(_frameSize, _frameSize, self.bounds.size.width - _frameSize, self.bounds.size.height - _frameSize);
}

- (void) resizeToProportionalImageSize {
    if(_imageView.image) {
        CGRect imageRect = FLRectFitInRectInRectProportionally(self.bounds, CGRectMake(0,0,_imageView.image.size.width, _imageView.image.size.height));
        CGPoint pt = FLRectGetCenter(self.frame);
        
        CGRect newFrame = CGRectInset(imageRect, -_frameSize, -_frameSize);
        newFrame = FLRectOptimizedForViewLocation(FLRectCenterOnPoint(newFrame, pt));
        self.frame = newFrame;
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

- (void) loadLatestImage {
    NSString* imagePath = self.loadingPath;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSImage* image = FLAutorelease([[NSImage alloc] initWithContentsOfFile:imagePath]);
        if(image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:image];
            });
        }
    }); 
}

- (void) setImageWithFilePath:(NSString*) imagePath {
    self.loadingPath = imagePath;
    
    if(_imageView.image == nil) {
        [self loadLatestImage];
    }
    else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(loadLatestImage) withObject:nil afterDelay:0.3];
    }
}

- (void) removeImage {
    _imageView.image = nil;
    _imageView.hidden = YES;
}

@end
