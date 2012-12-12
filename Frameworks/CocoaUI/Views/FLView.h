//
//  FLView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUICompatibility.h"

#if OSX
@interface FLView : NSView {
@private
    NSColor* _backgroundColor;
}
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;

@end
#endif

