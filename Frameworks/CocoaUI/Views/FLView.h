//
//  FLView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if OSX
@interface NSView (FLCompatibility)
@property (readwrite, assign, nonatomic) BOOL userInteractionEnabled;
- (void) setNeedsLayout;    // calls setNeedsDisplay:YES
- (void) setNeedsDisplay;   // calls setNeedsDisplay:YES
@end

@interface FLView : NSView {
@private
    NSColor* _backgroundColor;
}
@property (readwrite, strong, nonatomic) NSColor* backgroundColor;
@end
#endif


@interface SDKViewController (FLNibLoading)
@property (readonly, strong, nonatomic) NSString* defaultNibName;
- (id) initWithDefaultNibName;
- (id) initWithDefaultNibName:(NSBundle *)nibBundleOrNil;
@end