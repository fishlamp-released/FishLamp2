//
//	FLBackButtonShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	return FLAutorelease([[FLBackButtonShapeWidget alloc] initWithPointSize:pointSize]);
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
	FLCreateRectPathBackButtonShape(path, rect, self.cornerRadius, _pointSize);
}

@end
