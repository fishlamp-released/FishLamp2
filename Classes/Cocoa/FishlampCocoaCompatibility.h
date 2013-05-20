
#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

#if IOS
    #import <UIKit/UIKit.h>
    #import <CoreGraphics/CoreGraphics.h>
    #import <MobileCoreServices/MobileCoreServices.h>
    #import <ImageIO/ImageIO.h>
#else
    #import <Cocoa/Cocoa.h>
    #import <AppKit/AppKit.h>
    #import <CoreServices/CoreServices.h>
#endif

//#if IOS
//    #define UIView           UIView
//    #define UIViewController UIViewController
//    #define UIImage          UIImage
//    #define UIColor          UIColor
//    #define CGRect           CGRect
//    #define CocoaPoint          CGPoint
//    #define CGSize           CGSize
//
//    #define NSStringFromCocoaPoint NSStringFromCGPoint
//    #define NSStringFromCocoaRect  NSStringFromCGRect
//    #define NSStringFromCocoaSize  NSStringFromCGSize
//
//    #define CocoaPointFromString CGPointFromString
//    #define CGSizeFromString CGSizeFromString
//    #define CGRectFromString CGRectFromString
//
//#else
//    #define UIImage          NSImage
//    #define UIColor          NSColor
//    #define UIView           NSView
//    #define UIViewController NSViewController
//    #define CGRect           NSRect
//    #define CocoaPoint          NSPoint
//    #define CGSize           CGSize
//
//    #define NSStringFromCocoaPoint NSStringFromNSPoint
//    #define NSStringFromCocoaRect  NSStringFromNSRect
//    #define NSStringFromCocoaSize  NSStringFromNSSize
//
//    #define CocoaPointFromString NSPointFromString
//    #define CGSizeFromString NSSizeFromString
//    #define CGRectFromString NSRectFromString
//
//#endif

#import "NSValue+CocoaCompatibility.h"