//
//  GtCropImageViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCropImageViewController.h"
#import "GtGradientButton.h"

@implementation GtCropImageViewController

@synthesize delegate = m_delegate;

- (void) setImage:(UIImage*) image
{
    GtAssignObject(m_image, image);
    
    if(m_imageView)
    {
        m_imageView.image = image;
    }
}

- (void) dealloc
{
    GtRelease(m_imageView);
    GtSuperDealloc();
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    GtReleaseWithNil(m_imageView);
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
    
    bounds = GtRectInsetTop(bounds, GtRectGetBottom(self.navigationController.navigationBar.frame));
    
    m_imageView = [[GtCropImageView alloc] initWithFrame:bounds];
    m_imageView.image = m_image;
    [self.view addSubview:m_imageView];
    
    [self.buttonbar addViewToRightSide:[GtToolbarButton toolbarButton:GtButtonColorBrightBlue title:NSLocalizedString(@"Crop", nil) target:self action:@selector(_done:)] forKey:@"done" animated:NO];
    [self.buttonbar addViewToLeftSide:[GtToolbarButton toolbarButton:NSLocalizedString(@"Cancel", nil) target:self action:@selector(_cancel:)] forKey:@"done" animated:NO];

}

@end
