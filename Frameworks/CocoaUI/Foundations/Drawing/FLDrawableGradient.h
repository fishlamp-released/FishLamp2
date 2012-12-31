//
//  FLGradientDrawing.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawable.h"
#import "FLColorRange.h"

@interface FLDrawableGradient : FLDrawable {
@private
    FLColorRange* _colorRange;
}
@property (readwrite, strong, nonatomic) FLColorRange* colorRange;

- (id) initWithColorRange:(FLColorRange*) colorRange;

@end
