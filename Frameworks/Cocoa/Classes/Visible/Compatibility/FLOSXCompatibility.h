//
//  FLOSXCompatibility.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#if OSX

#define NSView_                     NSView
#define UIView_                     NSView

#define NSViewController_           NSViewController
#define UIViewController_           NSViewController

#define NSImage_                    NSImage
#define UIImage_                    NSImage

#define NSColor_                    NSColor
#define UIColor_                    NSColor


@interface NSImage_ (FLCompatibility)
- (CGImageRef) CGImage;
- (id) initWithCGImage:(CGImageRef) image;
+ (NSImage_*) imageWithCGImage:(CGImageRef) image;

+ (NSImage_*) imageWithData:(NSData*) data;
@end

// TODO: MOVE THIS
// use our own enum I guess. Not finding equivelent in AppKit
enum {
    UIControlStateNormal       = 0,                       
    UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
    UIControlStateDisabled     = 1 << 1,
    UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
    UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
    UIControlStateReserved     = 0xFF000000               // flags reserved for internal framework use
};

typedef NSUInteger UIControlState;
    
// TODO - get rid of these
#define DeviceIsPad()   NO
#define DeviceIsPhone() NO
#define DeviceIsPod()   NO
#define DeviceIsSimulator() NO
 
#endif