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

@synthesize delegate = m_delegate;

- (void) setImage:(UIImage*) image
{
    FLAssignObject(m_image, image);
    
    if(m_imageView)
    {
        m_imageView.image = image;
    }
}

- (void) dealloc
{
    FLRelease(m_imageView);
    FLSuperDealloc();
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    FLReleaseWithNil(m_imageView);
}

- (void) _done:(id) sender
{
    [m_delegate cropImageViewController:self didCropImage:m_imageView.image];
}

- (void) _cancel:(id) sender
{
    [m_delegate cropImageViewControllerWasCancelled:self];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    
    bounds = FLRectInsetTop(bounds, FLRectGetBottom(self.navigationController.navigationBar.frame));
    
    m_imageView = [[FLCropImageView alloc] initWithFrame:bounds];
    m_imageView.image = m_image;
    [self.view addSubview:m_imageView];
    
    [self.buttonbar addViewToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:NSLocalizedString(@"Crop", nil) target:self action:@selector(_done:)] forKey:@"done" animated:NO];
    [self.buttonbar addViewToLeftSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil) target:self action:@selector(_cancel:)] forKey:@"done" animated:NO];

}

@end
