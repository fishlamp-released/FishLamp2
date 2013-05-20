//
//  GtServerSideImageWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtThumbnailWidget.h"
#import "GtActionContext.h"

@interface GtServerSideImageWidget : GtThumbnailWidget {
@private
	NSString* m_url;
}

- (void) setImageURL:(NSString*) url;


@end
