//
//  GtThumbnailWithTitleWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLabelWidget.h"
#import "GtThumbnailWidget.h"

#import "GtImageFrameWidget.h"

@protocol GtThumbnailWithTitleWidgetDelegate;

@interface GtThumbnailWithTitleWidget : GtWidget {
@private
	GtImageFrameWidget* m_imageFrame;
	GtLabelWidget* m_label;
}

@property (readonly, retain, nonatomic) GtImageFrameWidget* imageFrameWidget;
@property (readonly, retain, nonatomic) GtLabelWidget* titleLabelWidget;

- (void) setTitle:(NSString*) title;
- (void) setThumbnail:(UIImage*) image;

@end

