//
//  FLPhotoGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoGridViewController.h"
#import "FLPhotoGridViewCell.h"

@implementation FLPhotoGridViewController

//- (id) initWithGalleryDataProvider:(FLGalleryDataModel*) dataModel
//{
//    if((self = [super initWithGalleryDataProvider:dataModel 
//                cellFactory:[FLThumbnailGalleryGridViewCellFactory instance]
//                arrangement:nil]))
//    {
////        self.cellManager.arrangement = [FLHorizontalGridArrangement horizontalCellLayout:self];
//    }
//    
//    return self;
//}

//+ (id) photoGridViewController:(FLGalleryDataModel*) dataModel
//{
//    return autorelease_([[[self class] alloc] initWithGalleryDataProvider:dataModel]);
//}

//- (FLGridCell*) createGridViewCellForGridViewItem:(id) item
//{
//    return [FLPhotoGridViewCell photoGridViewCell:item];
//}

//- (FLSize) cellViewLayoutGetCellSize:(FLCellArrangement*) layout inBounds:(FLRect) bounds
//{
//    return self.view.frame.size;
//}

- (void) viewDidLoad
{
    [super viewDidLoad];

//    _buttonbarHost = [[FLView alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
//    _buttonbarHost.autoresizesSubviews = YES;
//    _buttonbarHost.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
//    _buttonbarHost.backgroundColor = [UIColor clearColor];
//    
//    FLGradientView* gradient = [[FLGradientView alloc] initWithFrame:_buttonbarHost.bounds];
//    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//    gradient.alpha = 0.6f;
//    [_buttonbarHost addSubview:gradient];
//    
//    FLDeprecatedButtonbarView* bar = self.buttonbar;
//    bar.title = self.title;
//    bar.frame = _buttonbarHost.bounds;
//    [_buttonbarHost addSubview:bar];
//    
//    [self.view addSubview:_buttonbarHost];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
//    FLReleaseWithNil_(_buttonbarHost);
}

- (void) dealloc
{
//    release_(_buttonbarHost);
    super_dealloc_();
}

- (void) scrollToGalleryItem:(id<FLGalleryObject>) galleryItem    
    animated:(BOOL) animated
{
//    NSInteger idx = [[self.dataModel gridViewItems] indexForObjectWithKey:galleryItem.dataRefKey];
//    FLGridCell* cell = [self.cellManager cellAtIndex:idx];
//    [self.scrollView scrollRectToVisible:cell.frame animated:animated];
}

- (void) beginShowingGalleryItem:(id<FLGalleryObject>) galleryItem
             fromRectInSuperview:(FLRect) rect
{
    [self scrollToGalleryItem:galleryItem animated:NO];
    self.view.frame = self.view.superview.bounds;
}             


@end
