//
//	FLRoundRectWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLRoundRectWidget.h"
#import "FLPathUtilities.h"

@implementation FLRoundRectWidget

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(FLRect) rect
{
	FLCreateRectPath(path, rect, self.cornerRadius);
}

@end
