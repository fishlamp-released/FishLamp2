//
//	FLRoundRectWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRoundRectWidget.h"
#import "FLPathUtilities.h"

@implementation FLRoundRectWidget

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
	FLCreateRectPath(path, rect, self.cornerRadius);
}

@end
