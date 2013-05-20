//
//  GtPhotoGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoGridViewController.h"
#import "GtPhotoGridViewCell.h"
#import "GtBigThumbnailGallery.h"

@implementation GtPhotoGridViewController

//- (id) initWithGalleryDataProvider:(GtGalleryDataProvider*) dataProvider
//{
//    if((self = [super initWithGalleryDataProvider:dataProvider 
//                cellFactory:[GtThumbnailGalleryGridViewCellFactory instance]
//                viewLayout:nil]))
//    {
////        self.cellManager.viewLayout = [GtHorizontalGridViewLayout horizontalCellLayout:self];
//    }
//    
//    return self;
//}

//+ (id) photoGridViewController:(GtGalleryDataProvider*) dataProvider
//{
//    return GtReturnAutoreleased([[[self class] alloc] initWithGalleryDataProvider:dataProvider]);
//}

//- (GtGridViewCell*) createGridViewCellForGridViewItem:(id) item
//{
//    return [GtPhotoGridViewCell photoGridViewCell:item];
//}

- (GtViewContentsDescriptor) describeViewContents
{
    return GtViewContentsDescriptorMake(GtViewContentItemToolbarAndStatusBar, GtViewContentItemNone);
}

- (CGSize) cellViewLayoutGetCellSize:(GtCellViewLayout*) layout
{
    return self.view.frame.size;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

//    m_buttonbarHost = [[GtWidgetView alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
//    m_buttonbarHost.autoresizesSubviews = YES;
//    m_buttonbarHost.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
//    m_buttonbarHost.backgroundColor = [UIColor clearColor];
//    
//    GtGradientView* gradient = [[GtGradientView alloc] initWithFrame:m_buttonbarHost.bounds];
//    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//    gradient.alpha = 0.6f;
//    [m_buttonbarHost addSubview:gradient];
//    
//    GtButtonbarView* bar = self.buttonbar;
//    bar.title = self.title;
//    bar.frame = m_buttonbarHost.bounds;
//    [m_buttonbarHost addSubview:bar];
//    
//    [self.view addSubview:m_buttonbarHost];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
//    GtReleaseWithNil(m_buttonbarHost);
}

- (void) dealloc
{
//    GtRelease(m_buttonbarHost);
    GtSuperDealloc();
}

- (void) scrollToGalleryItem:(id<GtGalleryObject>) galleryItem    
    animated:(BOOL) animated
{
//    NSInteger idx = [[self.dataProvider gridViewItems] indexForObjectWithKey:galleryItem.gridViewObjectID];
//    GtGridViewCell* cell = [self.cellManager cellAtIndex:idx];
//    [self.scrollView scrollRectToVisible:cell.frame animated:animated];
}

- (void) beginShowingGalleryItem:(id<GtGalleryObject>) galleryItem
             fromRectInSuperview:(CGRect) rect
{
    [self scrollToGalleryItem:galleryItem animated:NO];
    self.view.frame = self.view.superview.bounds;
}             


@end
