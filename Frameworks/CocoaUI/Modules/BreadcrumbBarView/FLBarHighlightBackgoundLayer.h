//
//  FLBarHighlightBackgound.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FLCocoaUIRequired.h"

@interface FLBarHighlightBackgoundLayer : CALayer {
@private
    NSColor* _lineColor;
}
@property (readwrite, strong, nonatomic) NSColor* lineColor;

@end
