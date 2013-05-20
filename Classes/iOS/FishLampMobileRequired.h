//
//	FishLamp.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreText/CoreText.h>

#import "FishLampCocoa.h"

#ifndef UNIT_TEST
#define UNIT_TEST DEBUG
#endif

#ifndef __GT_MEMORY_MONITOR
#define __GT_MEMORY_MONITOR 0
#endif

#ifndef ALLOCATION_HOOKS
#define ALLOCATION_HOOKS __GT_MEMORY_MONITOR
#endif

/*
This is a known bug with the iOS 4.1 SDK and building using LLVM for the iPhone Simulator. You can read all about it in this thread on Apple's Developer Forums.

The recommended solution is to add the following to Other C Flags in your project's build settings: -D__IPHONE_OS_VERSION_MIN_REQUIRED=040100 where you replace 040100 with your deployment target version (030000 for 3.0, for example).
*/

#if DEBUG
	#ifndef GT_CHECK_RECT_SANITY
	#define GT_CHECK_RECT_SANITY 0
	#endif
#else
	#define GT_CHECK_RECT_SANITY 0
#endif

#if __GT_MEMORY_MONITOR
#undef ALLOCATION_HOOKS
#define ALLOCATION_HOOKS 1
#endif

#ifndef __IPHONE_5_0
#warning ERROR! FishLamp Requires iPhone SDK >= 5.0. See FishLampRequired.h for compatibility help.
#endif

#ifndef GT_CUSTOM_CAMERA
	#if TARGET_IPHONE_SIMULATOR
	#define GT_CUSTOM_CAMERA 0
	#else 
	#define GT_CUSTOM_CAMERA 0 //TARGET_OS_EMBEDDED
	#endif
#endif	 
#import "NSObject+GtStreamableObject.h"

#import "GtMobileDebug.h"
#import "GtGeometry.h"

#import "UIColor+GtMoreColors.h"
#import "UIView+GtViewRotation.h"
#import "UIView+GtViewGeometry.h"
#import "UIView+GtViewAutoLayout.h"
#import "UITableView+GtExtras.h"
#import "UILabel+GtExtras.h"
#import "UIDevice+GtExtras.h"
#import "UIToolbar+GtExtras.h"
#import "UIImageView+GtViewGeometry.h"
#import "UIView+GtTextView.h"
#import "UIView+ViewAnimation.h"
#import "UIApplication+GtExtras.h"

#import "GtThemeManager.h"
#import "GtTheme.h"

