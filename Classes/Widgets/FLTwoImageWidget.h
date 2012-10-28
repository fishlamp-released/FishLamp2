//
//	FLTwoImageWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
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
