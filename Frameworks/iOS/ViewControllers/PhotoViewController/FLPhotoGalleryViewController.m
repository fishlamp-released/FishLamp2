//
//  FLPhotoGalleryViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoGalleryViewController.h"
#import "FLViewControllerStack.h"
#import "FLPhotoThumbnailGridViewCell.h"

@interface FLZoomAnimation : NSObject<FLViewControllerTransitionAnimation>
FLSingletonProperty(FLZoomAnimation);
@end

@implementation FLZoomAnimation
FLSynthesizeSingleton(FLZoomAnimation);

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(FLPhotoGalleryViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
//    FLPhotoThumbnailGridViewCell* cell = (FLPhotoThumbnailGridViewCell*) parentViewController.selectedCell; 

    CGFloat savedParentAlpha = parentViewController.view.alpha;
    CGFloat savedNewAlpha = viewController.view.alpha;
    viewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.4
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = 0.0;
                    viewController.view.alpha = savedNewAlpha;
                } 
                completion:^(BOOL completed) {
                    parentViewController.view.alpha = savedParentAlpha;
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    if(finishedBlock)
        finishedBlock(viewController, parentViewController);
}
@end


@interface FLPhotoGalleryViewController ()

@end

@implementation FLPhotoGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (FLDataProviderPhotoViewController*) createPhotoViewControllerForCell:(FLGridCell*) cell
{
    return nil;
}

- (void) gridViewCellWasSelected:(FLGridCell*) cell
{
    cell.selected = NO;

    FLDataProviderPhotoViewController* newController = [self createPhotoViewControllerForCell:cell];

    NSInteger photoIndex = [self.cellCollection indexForKey:cell.cellDataRefKey];
    [newController setCurrentPhotoIndex:photoIndex animated:NO];
    
    FLAssertIsNotNil(self.viewControllerStack);
    
    [self.viewControllerStack pushViewController:newController withAnimation:[self selectionAnimationForCell:cell]];
}

- (id<FLViewControllerTransitionAnimation>) selectionAnimationForCell:(FLGridCell*) cell
{
    return [FLCrossFadeAnimation viewControllerTransitionAnimation];
}

@end
