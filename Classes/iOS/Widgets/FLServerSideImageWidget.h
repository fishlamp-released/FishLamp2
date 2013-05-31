//
//  FLServerSideImageWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLThumbnailWidget.h"

@interface FLServerSideImageWidget : FLThumbnailWidget {
@private
	NSString* _url;
}

- (void) startDownloadingImage:(NSString*) url
              inViewController:(UIViewController*) viewController;

@end
