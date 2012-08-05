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

//- (id) initWithGalleryDataProvider:(FLGalleryDataProvider*) dataProvider
//{
//    if((self = [super initWithGalleryDataProvider:dataProvider 
//                cellFactory:[FLThumbnailGalleryGridViewCellFactory instance]
//                arrangement:nil]))
//    {
////        self.cellManager.subviewArrangement = [FLHorizontalGridArrangement horizontalCellLayout:self];
//    }
//    
//    return self;
//}

//+ (id) photoGridViewController:(FLGalleryDataProvider*) dataProvider
//{
//    return FLReturnAutoreleased([[[self class] alloc] initWithGalleryDataProvider:dataProvider]);
//}

//- (FLGridViewCell*) createGridViewCellForGridViewItem:(id) item
//{
//    return [FLPhotoGridViewCell photoGridViewCell:item];
//}

//- (CGSize) cellViewLayoutGetCellSize:(FLCellArrangement*) layout inBounds:(CGRect) bounds
//{
//    return self.view.frame.size;
//}

- (void) viewDidLoad
{
    [super viewDidLoad];

//    m_buttonbarHost = [[FLView alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
//    m_buttonbarHost.autoresizesSubviews = YES;
//    m_buttonbarHost.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
//    m_buttonbarHost.backgroundColor = [UIColor clearColor];
//    
//    FLGradientView* gradient = [[FLGradientView alloc] initWithFrame:m_buttonbarHost.bounds];
//    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//    gradient.alpha = 0.6f;
//    [m_buttonbarHost addSubview:gradient];
//    
//    FLButtonbarView* bar = self.buttonbar;
//    bar.title = self.title;
//    bar.frame = m_buttonbarHost.bounds;
//    [m_buttonbarHost addSubview:bar];
//    
//    [self.view addSubview:m_buttonbarHost];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
//    FLReleaseWithNil(m_buttonbarHost);
}

- (void) dealloc
{
//    FLRelease(m_buttonbarHost);
    FLSuperDealloc();
}

- (void) scrollToGalleryItem:(id<FLGalleryObject>) galleryItem    
    animated:(BOOL) animated
{
//    NSInteger idx = [[self.dataProvider gridViewItems] indexForObjectWithKey:galleryItem.gridViewObjectId];
//    FLGridViewCell* cell = [self.cellManager cellAtIndex:idx];
//    [self.scrollView scrollRectToVisible:cell.frame animated:animated];
}

- (void) beginShowingGalleryItem:(id<FLGalleryObject>) galleryItem
             fromRectInSuperview:(CGRect) rect
{
    [self scrollToGalleryItem:galleryItem animated:NO];
    self.view.frame = self.view.superview.bounds;
}             


@end
