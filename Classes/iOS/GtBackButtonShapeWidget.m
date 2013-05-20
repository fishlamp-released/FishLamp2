//
//	GtBackButtonShapeWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBackButtonShapeWidget.h"
#import "GtPathUtilities.h"

@implementation GtBackButtonShapeWidget

@synthesize pointSize = m_pointSize;

- (id) initWithPointSize:(CGFloat) pointSize
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		m_pointSize = pointSize;
	}
	
	return self;
}

+ (GtBackButtonShapeWidget*) backButtonShapeWidget:(CGFloat) pointSize
{
	return GtReturnAutoreleased([[GtBackButtonShapeWidget alloc] initWithPointSize:pointSize]);
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
	GtCreateRectPathBackButtonShape(path, rect, self.cornerRadius, m_pointSize);
}

@end
