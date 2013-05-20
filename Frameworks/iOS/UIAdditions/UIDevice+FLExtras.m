//
//	FLDevice.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/15/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIDevice+FLExtras.h"
#import <sys/utsname.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#if DEPRECATED
static UIDeviceOrientation s_lastOrientation			= UIDeviceOrientationUnknown;
static UIDeviceOrientation s_currentOrientation			= UIDeviceOrientationPortrait;
static UIDeviceOrientation s_lastLandscapeOrientation	= UIDeviceOrientationUnknown;
static UIDeviceOrientation s_lastPortraitOrientation	= UIDeviceOrientationUnknown;
#endif
 
@implementation UIDevice (FLExtras)

- (NSString*) machineName
{
	struct utsname u;
	uname(&u);
	return [NSString stringWithFormat:@"%s", u.machine];
}

- (CGFloat) tabBarHeight
{
	return FLTabBarHeight;
}

- (CGFloat) tabBarHeightPortait
{
	return FLTabBarHeight;
}

- (CGFloat) tabBarHeightLandscape
{
	return FLTabBarHeight;
}

- (BOOL) isRotatedToLandscapeOrientation
{
	return UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
}

- (BOOL) isRotatedToPortaitOrientation
{
	return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) || UIDeviceOrientationUnknown == [UIDevice currentDevice].orientation;
}

- (CGFloat) keyboardHeight
{
	return FLKeyboardHeight;
}

- (CGFloat) statusBarHeight
{
	return MIN([UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width);
}

- (CGFloat) statusBarWidth
{
	return MAX([UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width);
}

- (CGFloat) toolbarHeight
{
	return DeviceIsPad() ? 
		FLToolbarHeightPortrait :
		self.isRotatedToLandscapeOrientation ?
		self.toolbarHeightLandscape :
		self.toolbarHeightPortrait;
}

- (CGFloat) toolbarHeightPortrait
{
	return FLToolbarHeightPortrait;
}

- (CGFloat) toolbarHeightLandscape
{
	return FLToolbarHeightLandscape;
}

- (CGFloat) navigationBarHeight
{
	return DeviceIsPad() ?
		FLNavigationBarHeightPortrait :
	
		self.isRotatedToLandscapeOrientation ?
		self.navigationBarHeightLandscape :
		self.navigationBarHeightPortrait;
}

- (CGFloat) navigationBarHeightPortrait
{
	return FLNavigationBarHeightPortrait;
}

- (CGFloat) navigationBarHeightLandscape
{
	return FLNavigationBarHeightLandscape;
}

#if DEPRECATED

- (UIDeviceOrientation) lastLandscapeOrientation
{
	return s_lastLandscapeOrientation;
}

- (UIDeviceOrientation) lastOrientation
{
	return s_lastOrientation;
}

- (UIDeviceOrientation) lastPortaitOrientation
{
	return s_lastPortraitOrientation;
}

- (void) handleRotatedEvent:(id) sender
{
	s_lastOrientation = s_currentOrientation;
	s_currentOrientation = [UIDevice currentDevice].orientation;
	if(UIDeviceOrientationIsLandscape(s_lastOrientation))
	{
		s_lastLandscapeOrientation = s_lastOrientation;
	}
	else
	{
		s_lastPortraitOrientation = s_lastOrientation;
	}
}

#endif

+ (unsigned long long) freeMemoryInBytes 
{
	unsigned long long totalMemory = 0;
	unsigned long long used = 0;
	unsigned long long freeMem = 0;
	GetMemoryStats(&totalMemory, &used, &freeMem);
	return freeMem;
}

+ (unsigned long long) memorySizeInBytes
{
	unsigned long long totalMemory = 0;
	unsigned long long used = 0;
	unsigned long long freeMem = 0;
	GetMemoryStats(&totalMemory, &used, &freeMem);
	return totalMemory;
}

+ (unsigned long long) usedMemoryInBytes
{
	unsigned long long totalMemory = 0;
	unsigned long long used = 0;
	unsigned long long freeMem = 0;
	GetMemoryStats(&totalMemory, &used, &freeMem);
	return used;
}

// TODO fix this
- (BOOL) isAtLeastIPhone4
{
	return [UIDevice memorySizeInBytes]/1048576.0 > 128;
}

- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
	sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
	char *answer = malloc(size);
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	free(answer);
	return results;
}

- (NSString *) platform
{
	return [self getSysInfoByName:"hw.machine"];
}


// Thanks, Atomicbird
- (NSString *) hwmodel
{
	return [self getSysInfoByName:"hw.model"];
}

- (NSUInteger) platformType
{
	NSString *platform = [self platform];
	// if ([platform isEqualToString:@"XX"]) return UIDeviceUnknown;

	if ([platform isEqualToString:@"iFPGA"]) return UIDeviceIFPGA;

	if ([platform isEqualToString:@"iPhone1,1"]) return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"]) return UIDevice3GiPhone;
	if ([platform hasPrefix:@"iPhone2"]) return UIDevice3GSiPhone;
	if ([platform hasPrefix:@"iPhone3"]) return UIDevice4iPhone;
	if ([platform hasPrefix:@"iPhone4"]) return UIDevice5iPhone;

	if ([platform isEqualToString:@"iPod1,1"]) return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"]) return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"]) return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"]) return UIDevice4GiPod;

	if ([platform isEqualToString:@"iPad1,1"]) return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"]) return UIDevice2GiPad;

	/*
	MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.... SORRY!
	*/

	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;

	if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) // thanks Jordan Breeding
	{
		if ([[UIScreen mainScreen] bounds].size.width < 768)
			return UIDeviceiPhoneSimulatoriPhone;
		else
			return UIDeviceiPhoneSimulatoriPad;

		return UIDeviceiPhoneSimulator;
	}
	return UIDeviceUnknown;
}

- (NSString *) platformString
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
		case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
		case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;

		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;

		case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
		case UIDevice2GiPad : return IPAD_2G_NAMESTRING;

		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPhone: return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPad: return IPHONE_SIMULATOR_IPAD_NAMESTRING;

		case UIDeviceIFPGA: return IFPGA_NAMESTRING;

		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
	}
}

- (BOOL) isPhone
{
	return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone);
}
- (BOOL) isPad
{
	return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}
- (BOOL) isPod
{
	return [[self platform] rangeOfString:@"iPod"].length > 0;
}

- (NSString*) deviceDisplayName
{
	if(DeviceIsPad()) return NSLocalizedString(@"iPad", nil);
	if(DeviceIsPod()) return NSLocalizedString(@"iPod", nil);
	return NSLocalizedString(@"iPhone", nil);
}

-(BOOL)deviceHasMultipleCores {
    // This is a helper that allows us to degrade the UI a bit for better performance on iPad 1
    static unsigned int ncpu = 0;
    if (!ncpu) {
        size_t len;
        len = sizeof(ncpu);
        sysctlbyname ("hw.ncpu",&ncpu,&len,NULL,0);    
    }
    return (ncpu > 1);
}


@end

void GetMemoryStats(unsigned long long* totalMemory, unsigned long long* used, unsigned long long* freeMem)
{
	mach_port_t host_port = mach_host_self();
	mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
	vm_size_t pagesize = 0;
	
	host_page_size(host_port, &pagesize);		 
 
	vm_statistics_data_t vm_stat;
			  
	if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
	{
	   FLLog(@"Failed to fetch vm statistics");
	   return;
	}
 
	/* Stats in bytes */ 
	*used = (vm_stat.active_count +
						  vm_stat.inactive_count +
						  vm_stat.wire_count) * pagesize;
	*freeMem = vm_stat.free_count * pagesize;
	*totalMemory = *used + *freeMem;
}




