//
//	GtBackButtonShapeWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtShapeWidget.h"

@interface GtBackButtonShapeWidget : GtShapeWidget {
@private
	CGFloat m_pointSize;
}

@property (readwrite, assign, nonatomic) CGFloat pointSize;

+ (GtBackButtonShapeWidget*) backButtonShapeWidget:(CGFloat) point;

@end
