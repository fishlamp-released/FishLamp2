//
//  FLCropImageViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCropImageViewController.h"
#import "FLGradientButton.h"

@implementation FLCropImageViewController

@synthesize delegate = _delegate;

- (void) setImage:(UIImage*) image
{
    FLRetainObject_(_image, image);
    
    if(_imageView)
    {
        _imageView.image = image;
    }
}

- (void) dealloc
{
    mrc_release_(_imageView);
    mrc_super_dealloc_();
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    FLReleaseWithNil_(_imageView);
}

- (void) _done:(id) sender
{
    [_delegate cropImageViewController:self didCropImage:_imageView.image];
}

- (void) _cancel:(id) sender
{
    [_delegate cropImageViewControllerWasCancelled:self];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    FLRect bounds = self.view.bounds;
    
    bounds = FLRectInsetTop(bounds, FLRectGetBottom(self.navigationController.navigationBar.frame));
    
    _imageView = [[FLCropImageView alloc] initWithFrame:bounds];
    _imageView.image = _image;
    [self.view addSubview:_imageView];
    
    [self.buttonbar addViewToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:NSLocalizedString(@"Crop", nil) target:self action:@selector(_done:)] forKey:@"done" animated:NO];
    [self.buttonbar addViewToLeftSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil) target:self action:@selector(_cancel:)] forKey:@"done" animated:NO];

}

@end
