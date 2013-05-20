//
//	GtTwoImageWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtImageWidget.h"

@interface GtTwoImageWidget : GtWidget {
@private
	GtImageWidget* m_bottomImageWidget;
	GtImageWidget* m_topImageWidget;
}

@property (readonly, retain, nonatomic) GtImageWidget* topImageWidget;
@property (readonly, retain, nonatomic) GtImageWidget* bottomImageWidget;

- (void) releaseImages;

@end
