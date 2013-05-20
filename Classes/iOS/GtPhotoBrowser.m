//
//  GtPhotoBrowser.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoBrowser.h"

@implementation GtPhotoBrowser

- (void) addButtonsToTopToolbar:(GtAsyncThumbnailToolBar*) toolbar
{
    if(DeviceIsPad())
	{
        [toolbar addButtonForKey:@"slideshow" imageName:@"playicon.png" iconColor:GtIconColorGray target:self action:@selector(handleSlideShowPress:)];
    }

    [toolbar addButtonForKey:@"close" imageName:@"x.png" iconColor:GtIconColorGray target:self action:@selector(closeSelf:)];
}

- (void) createTopToolbar
{
    GtAsyncThumbnailToolBar* toolbar = [[GtAsyncThumbnailToolBar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    
    [self addButtonsToTopToolbar:toolbar];
    
    [self.view addSubview:toolbar];
    self.topToolbar = toolbar;
}

- (void) updateTitleBar:(NSString*) title
{
    GtAsyncThumbnailToolBar* toolbar = (GtAsyncThumbnailToolBar*) self.topToolbar;

    if(GtStringIsEmpty(title))
    {
        title = NSLocalizedString(@"Untitled", @"untitled photo in photo view");
    }
    
    [toolbar.title clearAllStrings];
    
    toolbar.thumbnail = nil;
    [toolbar startSpinner];

    id galleryItem = [[self.dataProvider.cellCollection objectAtIndex:self.currentPhotoIndex] gridViewObject];

    GtAsyncEventHandler* handler = [GtAsyncEventHandler asyncEventHandler:self.actionContext];
    
    handler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
        [toolbar.title updateString:[data gridViewDisplayName] forKey:@"user"];
        [toolbar.title updateString:@" > " forKey:@"d1"];
        [toolbar.title updateString:@"Gallery Name" forKey:@"gallery"];
        [toolbar.title updateString:@" > " forKey:@"d2"];
        [toolbar.title updateString:title forKey:@"photo"];
    };
    
    [self.dataProvider.galleryDataProvider beginLoadingUserByID:[galleryItem ownerID] 
                                                   eventHandler:handler];


//	if(self.centerView)
//	{
//		self.title = title;
//		self.backButtonTitle = NSLocalizedString(@"Back", nil);
//	}
//	
//	self.buttonbar.subtitle = 
//        [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), m_currentPhotoIndex + 1, self.photoCount];
}

@end
