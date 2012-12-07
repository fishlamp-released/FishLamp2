//
//  FLTriangleWidget.m
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTriangleShapeWidget.h"
#import "FLPathUtilities.h"

@implementation FLTriangleShapeWidget

@synthesize triangleCorner = _triangleCorner;

- (void) setTriangleCorner:(FLTriangleCorner) corner {
    _triangleCorner = corner;
    [self setNeedsDisplay];
}

- (id) initWithTriangleCorner:(FLTriangleCorner) corner {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _triangleCorner = corner;
    }
    
    return self;
}

+ (FLTriangleShapeWidget*) triangleShapeWidget:(FLTriangleCorner) corner
{
	return FLAutorelease([[[self class] alloc] initWithTriangleCorner:corner]);
}

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect
{
    CGRectInset(rect, -2, -2);

	FLSetPathToTriangleInRectCorner(path, rect, self.triangleCorner);
}


@end
