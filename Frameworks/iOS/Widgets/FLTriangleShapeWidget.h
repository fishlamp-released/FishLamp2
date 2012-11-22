//
//  FLTriangleWidget.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLShapeWidget.h"
#import "FLPathUtilities.h"

// FLTriangleCorner defined in FLPathUtilities.h

@interface FLTriangleShapeWidget : FLShapeWidget {
@private
    FLTriangleCorner _triangleCorner;
}

@property (readwrite, assign, nonatomic) FLTriangleCorner triangleCorner;

- (id) initWithTriangleCorner:(FLTriangleCorner) corner;

+ (FLTriangleShapeWidget*) triangleShapeWidget:(FLTriangleCorner) corner;


@end
