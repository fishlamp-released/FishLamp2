//
//	GtRoundRectWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRoundRectWidget.h"
#import "GtPathUtilities.h"

@implementation GtRoundRectWidget

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
	GtCreateRectPath(path, rect, self.cornerRadius);
}

@end
