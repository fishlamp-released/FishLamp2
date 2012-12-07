//
//  FLView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FLCocoaView : FLView {
@private
    NSColor* _backgroundColor;
}
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;

#if OSX
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
#endif

@end
