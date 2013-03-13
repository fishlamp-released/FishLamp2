//
//  FLImagePlaceholderView.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLSpinningProgressView.h"

@interface FLImagePlaceholderView : FLFramedView {
@private
    FLSpinningProgressView* _progress;
    IBOutlet NSImageView* _imageView;
    CGFloat _frameSize;
    BOOL _alwaysProportionallyResize;
    NSString* _loadingPath;
}

@property (readwrite, assign, nonatomic) CGFloat frameSize;
@property (readwrite, strong, nonatomic) NSImageView* imageView;
@property (readwrite, assign, nonatomic) BOOL alwaysProportionallyResize;

- (void) startAnimating;
- (void) stopAnimating;

- (void) resizeToProportionalImageSize;

- (void) setImage:(NSImage*) image;
- (void) setImageWithFilePath:(NSString*) path;

- (void) removeImage;

@end
