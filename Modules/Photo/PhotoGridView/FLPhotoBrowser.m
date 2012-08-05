 //
 //  FLPhotoBrowser.m
 //  FishLamp-iOS-Lib
 //
 //  Created by Mike Fullerton on 2/4/12.
 //  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
 //
 
 #import "FLPhotoBrowser.h"
 #import "FLViewControllerStack.h"

 @implementation FLPhotoBrowser
 
- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) toolbar
{
     if(DeviceIsPad())
 	{
         [toolbar addButtonForKey:@"slideshow" imageName:@"playicon.png" iconColor:FLIconColorGray target:self action:@selector(handleSlideShowPress:)];
     }
 
     [toolbar addButtonForKey:@"close" imageName:@"x.png" iconColor:FLIconColorGray target:self action:@selector(closeSelf:)];
 }
 
 - (void) createTopToolbar
 {
    FLAsyncThumbnailToolBar* toolbar = [[FLAsyncThumbnailToolBar alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, 44)];
    FLAutorelease(toolbar);
    
     [self addButtonsToTopToolbar:toolbar];
     
    [self.view addSubview:toolbar];
     self.topToolbar = toolbar;
 }
 
 - (void) closeSelf:(id) sender
 {
     [self.viewControllerStack popViewControllerAnimated:YES];
 }
 
 - (void) updateTitleBar:(NSString*) title
 {
    FLAsyncThumbnailToolBar* toolbar = (FLAsyncThumbnailToolBar*) self.topToolbar;

     if(FLStringIsEmpty(title))
     {
         title = NSLocalizedString(@"Untitled", @"untitled photo in photo view");
     }
     
    [toolbar.title clearAllStrings];
     
     toolbar.thumbnail = nil;
     [toolbar startSpinner];
 
     id galleryItem = [[self.dataProvider.cellCollection objectAtIndex:self.currentPhotoIndex] gridViewObject];
 
    FLAsyncEventHandler* handler = [FLAsyncEventHandler asyncEventHandler:self.actionContext];
     
    handler.onEvent = ^(FLAsyncEventHandler* theEventHandler, BOOL success, id result, FLAsyncEventHint hint) {
        if(success)
        {
            [toolbar.title updateString:[result gridViewDisplayName] forKey:@"user"];
            [toolbar.title updateString:@" > " forKey:@"d1"];
            [toolbar.title updateString:@"Gallery Name" forKey:@"gallery"];
            [toolbar.title updateString:@" > " forKey:@"d2"];
            [toolbar.title updateString:title forKey:@"photo"];
        }
    };
         
    [self.dataProvider.galleryDataProvider beginLoadingUserByID:[galleryItem ownerID] 
                                                    eventHandler:handler];
 

 }
 
 @end
