//
//  FLThumbnailWithTitleWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLabelWidget.h"
#import "FLThumbnailWidget.h"

#import "FLImageFrameWidget.h"

@protocol FLThumbnailWithTitleWidgetDelegate;

@interface FLThumbnailWithTitleWidget : FLWidget {
@private
	FLImageFrameWidget* _imageFrame;
	FLLabelWidget* _label;
}

@property (readonly, retain, nonatomic) FLImageFrameWidget* imageFrameWidget;
@property (readonly, retain, nonatomic) FLLabelWidget* titleLabelWidget;

- (void) setTitle:(NSString*) title;
- (void) setThumbnail:(UIImage*) image;

@end

