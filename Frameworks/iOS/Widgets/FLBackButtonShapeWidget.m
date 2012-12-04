//
//	FLBackButtonShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLBackButtonShapeWidget.h"
#import "FLPathUtilities.h"

@implementation FLBackButtonShapeWidget

@synthesize pointSize = _pointSize;

- (id) initWithPointSize:(CGFloat) pointSize
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		_pointSize = pointSize;
	}
	
	return self;
}

+ (FLBackButtonShapeWidget*) backButtonShapeWidget:(CGFloat) pointSize
{
	return autorelease_([[FLBackButtonShapeWidget alloc] initWithPointSize:pointSize]);
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(FLRect) rect
{
	FLCreateRectPathBackButtonShape(path, rect, self.cornerRadius, _pointSize);
}

@end
