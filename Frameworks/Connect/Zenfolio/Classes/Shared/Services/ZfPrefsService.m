//
//  ZFPrefsService.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFPrefsService.h"
#import "ZFAccessDescriptor.h"
#import "NSString+GUID.h"
#import "ZFStorageService.h"
#import "ZFBrowserViewOptions.h"

@interface ZFPrefsService ()
@property (readwrite, strong) ZFPreferences* prefs;
@end

@implementation ZFPrefsService

@synthesize prefs = _prefs;

+ (id) prefsService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) closeService {
    self.prefs = nil;
}

#if FL_MRC
- (void) dealloc {
    [_prefs release];
    [super dealloc];
}
#endif

- (ZFPreferences*) loadPreferences {
    @synchronized(self) {
    
        if(self.prefs) {
        // why is this returning a copy?
            return FLAutorelease([self.prefs copy]);
        }
    
        ZFPreferences* input = [ZFPreferences preferences];
        input.uid = [NSString zeroGuidString];
        ZFPreferences* output = [[[self.context userStorageService] documentsDatabase] loadObject:input];
        if(!output)
        {
            output = input;
        
            output.saveImagesToPhoneGalleryOnUploadValue = YES;
            output.defaultUploadSizeValue = 0;
            output.allowRefreshOnHomePageValue = NO;
        }
        
        self.prefs = output;
        
        return output;
        
    }
    
    return nil;
}

- (void) savePreferences:(ZFPreferences*) prefs {
    @synchronized(self) {
        [[[self.context userStorageService] documentsDatabase] saveObject:prefs];
        self.prefs = prefs;
    }
}

- (ZFLocalPreferences*) loadLocalPreferences
{
    FLFolder* folder = [[self.context userStorageService] documentsFolder];
    FLAssertNotNil_(folder);

	ZFLocalPreferences* prefs = [ZFLocalPreferences readFromFolder:folder];
    FLAssertNotNil_(prefs);
    
	if(prefs.defaultSlideshowOptions.speedValue == 0.0f) {
		prefs.defaultSlideshowOptions.speedValue = 5;
		[prefs writeToFile];
	}
	
	return prefs;
}

@end

@implementation ZFLocalPreferences (Utils)

- (void) setDefaults
{
	self.slideShowLengthValue = 5;
	self.saveImagesToPhoneGalleryOnUploadValue = YES;
	self.autoRotateImagesInSlideshowValue = NO;
	self.defaultUploadSizeValue = 0; // FULL: TODO, make enum
	self.allowRefreshOnHomePageValue = NO;
	self.showRecentGalleriesValue = YES;
	self.showFeaturedGalleriesValue = YES;
	self.defaultBrowserViewOptions = [ZFBrowserViewOptions browserViewOptions];

#if IOS
	self.defaultSlideshowOptions = [FLSlideshowOptions slideshowOptions];
	self.defaultSlideshowOptions.speedValue = 5;
#endif

	ZFAccessDescriptor* defaultAccessDescriptor = [[ZFAccessDescriptor alloc] init];
	defaultAccessDescriptor.IsDerivedValue = YES;
	defaultAccessDescriptor.AccessTypeValue = ZFAccessTypePrivate; // StringFromZfAccessType(ZFAccessTypePrivate);
	defaultAccessDescriptor.AccessMaskValue = ZFApiAccessMaskNone; // StringFromZfApiAccessMask(ZFApiAccessMaskNone);
	self.defaultAccessDescriptor = defaultAccessDescriptor;
	FLReleaseWithNil(defaultAccessDescriptor);
}

@end