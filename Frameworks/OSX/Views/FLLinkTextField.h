//
//  FLLinkTextField.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FLLinkTextField : NSTextField {
@private
    BOOL _mouseDown;
    BOOL _mouseIn;
    NSTrackingRectTag _boundsTrackingTag;
}

@end
