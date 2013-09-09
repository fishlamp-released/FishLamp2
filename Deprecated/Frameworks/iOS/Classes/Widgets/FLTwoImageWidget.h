//
//	FLTwoImageWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLImageWidget.h"

@interface FLTwoImageWidget : FLWidget {
@private
	FLImageWidget* _bottomImageWidget;
	FLImageWidget* _topImageWidget;
}

@property (readonly, retain, nonatomic) FLImageWidget* topImageWidget;
@property (readonly, retain, nonatomic) FLImageWidget* bottomImageWidget;

- (void) releaseImages;

@end
