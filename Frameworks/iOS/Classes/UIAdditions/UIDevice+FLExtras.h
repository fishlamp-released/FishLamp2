//
//	FLDevice.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/15/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define FLTabBarHeight 49
#define FLNavigationBarHeightPortrait 44
#define FLNavigationBarHeightLandscape 32
#define FLKeyboardHeight 216
#define FLStatusBarHeight 20
#define FLToolbarHeightPortrait 44
#define FLToolbarHeightLandscape 44

#define IFPGA_NAMESTRING @"iFPGA"


#define IPHONE_1G_NAMESTRING @"iPhone 1G"
#define IPHONE_3G_NAMESTRING @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING @"iPhone 3GS"
#define IPHONE_4_NAMESTRING @"iPhone 4"
#define IPHONE_5_NAMESTRING @"iPhone 5"
#define IPHONE_UNKNOWN_NAMESTRING @"Unknown iPhone"

#define IPOD_1G_NAMESTRING @"iPod touch 1G"
#define IPOD_2G_NAMESTRING @"iPod touch 2G"
#define IPOD_3G_NAMESTRING @"iPod touch 3G"
#define IPOD_4G_NAMESTRING @"iPod touch 4G"
#define IPOD_UNKNOWN_NAMESTRING @"Unknown iPod"

#define IPAD_1G_NAMESTRING @"iPad 1G"
#define IPAD_2G_NAMESTRING @"iPad 2G"
#define IPAD_UNKNOWN_NAMESTRING @"Unknown iPad"

#define IPOD_FAMILY_UNKNOWN_DEVICE @"Unknown iOS device"

#define IPHONE_SIMULATOR_NAMESTRING @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING @"iPad Simulator"

typedef enum {
	UIDeviceUnknown,

	UIDeviceiPhoneSimulator,
	UIDeviceiPhoneSimulatoriPhone, // both regular and iPhone 4 devices
	UIDeviceiPhoneSimulatoriPad,

	UIDevice1GiPhone,
	UIDevice3GiPhone,
	UIDevice3GSiPhone,
	UIDevice4iPhone,
	UIDevice5iPhone,

	UIDevice1GiPod,
	UIDevice2GiPod,
	UIDevice3GiPod,
	UIDevice4GiPod,

	UIDevice1GiPad, // both regular and 3G
	UIDevice2GiPad,

	UIDeviceUnknowniPhone,
	UIDeviceUnknowniPod,
	UIDeviceUnknowniPad,
	UIDeviceIFPGA,

} UIDevicePlatform;

@interface UIDevice (FLExtras) 

- (NSString*) machineName;

- (CGFloat) tabBarHeight;
- (CGFloat) tabBarHeightPortait;
- (CGFloat) tabBarHeightLandscape;

- (CGFloat) keyboardHeight;

- (CGFloat) statusBarHeight;
- (CGFloat) statusBarWidth;

- (CGFloat) toolbarHeight;
- (CGFloat) toolbarHeightPortrait;
- (CGFloat) toolbarHeightLandscape;

- (CGFloat) navigationBarHeight;
- (CGFloat) navigationBarHeightPortrait;
- (CGFloat) navigationBarHeightLandscape;

- (BOOL) isRotatedToLandscapeOrientation;
- (BOOL) isRotatedToPortaitOrientation;

#ifdef DEPRECATED
- (UIDeviceOrientation) lastLandscapeOrientation;
- (UIDeviceOrientation) lastPortaitOrientation;
- (UIDeviceOrientation) lastOrientation;

- (void) handleRotatedEvent:(id) sender;
#endif

+ (unsigned long long) freeMemoryInBytes;
+ (unsigned long long) memorySizeInBytes;
+ (unsigned long long) usedMemoryInBytes;

- (BOOL) isAtLeastIPhone4;


- (NSString*) platformString; 
- (NSUInteger) platformType;

- (BOOL) isPhone;
- (BOOL) isPad;
- (BOOL) isPod;

- (NSString*) deviceDisplayName; // e.g. iPod, iPhone, iPad

-(BOOL)deviceHasMultipleCores;

@end

extern
void GetMemoryStats(unsigned long long* totalMemory, unsigned long long* used, unsigned long long* free);

#undef DeviceIsPad
#undef DeviceIsPhone
#undef DeviceIsPod
#undef DeviceIsSimulator

#if __IPHONE_3_2
#define DeviceIsPad() [UIDevice currentDevice].isPad
#define DeviceIsPhone() [UIDevice currentDevice].isPhone
#define DeviceIsPod() [UIDevice currentDevice].isPod
#else
#define DeviceIsPad() NO
#endif

#if DEBUG

NS_INLINE
BOOL DeviceIsSimulator()
{   
#if TARGET_IPHONE_SIMULATOR
    return YES;
#endif

    return NO;
}

#endif
