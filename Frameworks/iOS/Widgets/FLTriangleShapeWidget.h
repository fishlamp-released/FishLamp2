//
//  FLTriangleWidget.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
