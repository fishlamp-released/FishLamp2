//
//  FLServerSideImageWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLThumbnailWidget.h"
#import "FLActionContext.h"

@interface FLServerSideImageWidget : FLThumbnailWidget {
@private
	NSString* _url;
}

- (void) setImageURL:(NSString*) url;


@end
