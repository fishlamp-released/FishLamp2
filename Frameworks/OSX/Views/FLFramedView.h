//
//  FLFramedView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"

@interface FLFramedView : NSView {
@private
    NSColor* _frameColor;
    NSColor* _backgroundColor;
}
@property (readwrite, strong, nonatomic) NSColor* frameColor;
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
@end
