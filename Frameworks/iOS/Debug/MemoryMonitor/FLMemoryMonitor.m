//
//	FLMemoryMonitor.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLMemoryMonitor.h"
#if __FL_MEMORY_MONITOR

#import <stdio.h>
#import <string.h>

#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#import <mach/task_info.h>


#import "FLGeometry.h"

#undef alloc
#undef release
#undef allocWithZone

NS_INLINE
CGRect AdjustFrame(CGRect frame)
{
	//frame.origin.y += 2;
	return FLRectOptimizedForViewSize(frame);
}

@implementation FLMemoryMonitor

FLSynthesizeSingleton(FLMemoryMonitor)

- (id) init
{
	if((self = [super init]))
	{
		_previousHook = [NSObject setAllocHook:self];
	}
	return self;
}

- (void) dealloc
{
	if(_timer)
	{
		[_timer invalidate];
	}
	
	FLReleaseWithNil(_leftLabel);
	FLReleaseWithNil(_rightLabel);

	FLSuperDealloc();
}

- (CGFloat) toMegabytes:(vm_size_t) size
{
	return ((float)size) / (1024.0 * 1024.0) + 0.05;
}

- (void) updateDisplayLabel
{
	if([NSThread isMainThread])
	{	
		UIView* superview = _leftLabel.superview;
		
		[superview bringSubviewToFront:_leftLabel];
		[superview bringSubviewToFront:_rightLabel];

		NSString* text1 = [[NSString alloc] initWithFormat:@"%0.1fmb", [self toMegabytes:_last]];
		_leftLabel.text = text1;
		FLReleaseWithNil(text1);
		
		CGFloat highWater = [self toMegabytes:_highWater];
		NSString* text2 = [[NSString alloc] initWithFormat:@"%0.1fmb", highWater];
		if(highWater > 20.0)
		{	
			_rightLabel.textColor = [UIColor redColor];
		}
		
		_rightLabel.text = text2;
		FLReleaseWithNil(text2);
		
		CGRect superviewBounds = superview.bounds;
		
		_rightLabel.frame = AdjustFrame(FLRectJustifyRectInRectBottomRight(superviewBounds, _rightLabel.frame));
		_leftLabel.frame = AdjustFrame(FLRectJustifyRectInRectBottom(superviewBounds, _leftLabel.frame));
	}
}

- (void) timerCallback:(id) sender
{
	if(_lastChange)
	{
		[self updateMemoryValues];
		[self updateDisplayLabel];
		
		_lastChange = 0;
	}
}

- (void) updateMemoryValues
{
	@synchronized(self)
	{
		struct task_basic_info info;
		mach_msg_type_number_t size = sizeof(info);
		kern_return_t kerr = task_info(mach_task_self(),
									 TASK_BASIC_INFO,
									 (task_info_t)&info,
									 &size);
		if( kerr == KERN_SUCCESS ) 
		{
			if(info.resident_size != _last)
			{
				_lastChange = [NSDate timeIntervalSinceReferenceDate];
				
				_last = info.resident_size;
				if(_last > _highWater)
				{
					_highWater = info.resident_size;
				}
			}
		} 
	}
}

- (void) initLabel:(UILabel*) label
{
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor blackColor];
//	label.font = [UIFont fontWithName:@"Courier New" size:11];
	label.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]-2];// fontWithName:@"Courier New" size:11];
	label.alpha = 0.8;
}
//OSAtomicIncrement32(&_timedOut)
- (void) start:(UIWindow*) window
{
	if(!_started)
	{
		_leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,40,10)];
		[self initLabel:_leftLabel];
		[window addSubview:_leftLabel];
		_leftLabel.textAlignment = UITextAlignmentLeft;
		
		_rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,40,10)];
		[self initLabel:_rightLabel];
		[window addSubview:_rightLabel];
		_rightLabel.textAlignment = UITextAlignmentRight;
		
	//	  _rightLabel.floatingType = UIViewFloatingTypeFloater;
	//	  _leftLabel.floatingType = UIViewFloatingTypeFloater;
		
		[self updateMemoryValues];
		_started = YES;
	
		if(!_timer)
		{
			_timer = [NSTimer timerWithTimeInterval:1.0 
				target:self 
				selector:@selector(timerCallback:) 
				userInfo:nil 
				repeats:YES];
			
			[[NSRunLoop mainRunLoop] addTimer:_timer 
				forMode:NSRunLoopCommonModes];
		}
	}
}
- (void) stop:(UIWindow*) window
{
	if(_started)
	{
		_started = NO;
		[_leftLabel removeFromSuperview];
		FLReleaseWithNil(_leftLabel);
		[_rightLabel removeFromSuperview];
		FLReleaseWithNil(_rightLabel);
	}
}

- (id) allocationHookAlloc:(id) object
{
	if(_started)
	{
		[self updateMemoryValues];
	}
	if(_previousHook) [_previousHook allocationHookAlloc:object];
	
	return object;
}

- (id) allocationHookRelease:(id) object
{
	if(_started)
	{	
		[self updateMemoryValues];
	}
	if(_previousHook) [_previousHook allocationHookRelease:object];
	
	return object;
}
@end

/*

// some example code

void printMemoryInfo()
{
	size_t length;
	int mib[6]; 
	int result;

	printf("Memory Info\n");
	printf("-----------\n");

	int pagesize;
	mib[0] = CTL_HW;
	mib[1] = HW_PAGESIZE;
	length = sizeof(pagesize);
	if (sysctl(mib, 2, &pagesize, &length, NULL, 0) < 0)
	{
		perror("getting page size");
	}
	printf("Page size = %d bytes\n", pagesize);
	printf("\n");

	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	
	vm_statistics_data_t vmstat;
	if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS)
	{
		printf("Failed to get VM statistics.");
	}
	
	double total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
	double wired = vmstat.wire_count / total;
	double active = vmstat.active_count / total;
	double inactive = vmstat.inactive_count / total;
	double free = vmstat.free_count / total;

	printf("Total =	   %8d pages\n", vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count);
	printf("\n");
	printf("Wired =	   %8d bytes\n", vmstat.wire_count * pagesize);
	printf("Active =   %8d bytes\n", vmstat.active_count * pagesize);
	printf("Inactive = %8d bytes\n", vmstat.inactive_count * pagesize);
	printf("Free =	   %8d bytes\n", vmstat.free_count * pagesize);
	printf("\n");
	printf("Total =	   %8d bytes\n", (vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count) * pagesize);
	printf("\n");
	printf("Wired =	   %0.2f %%\n", wired * 100.0);
	printf("Active =   %0.2f %%\n", active * 100.0);
	printf("Inactive = %0.2f %%\n", inactive * 100.0);
	printf("Free =	   %0.2f %%\n", free * 100.0);
	printf("\n");

	mib[0] = CTL_HW;
	mib[1] = HW_PHYSMEM;
	length = sizeof(result);
	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
	{
		perror("getting physical memory");
	}
	printf("Physical memory = %8d bytes\n", result);
	mib[0] = CTL_HW;
	mib[1] = HW_USERMEM;
	length = sizeof(result);
	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
	{
		perror("getting user memory");
	}
	printf("User memory =	  %8d bytes\n", result);
	printf("\n");
}

void printProcessorInfo()
{
	size_t length;
	int mib[6]; 
	int result;

	printf("Processor Info\n");
	printf("--------------\n");

	mib[0] = CTL_HW;
	mib[1] = HW_CPU_FREQ;
	length = sizeof(result);
	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
	{
		perror("getting cpu frequency");
	}
	printf("CPU Frequency = %d hz\n", result);
	
	mib[0] = CTL_HW;
	mib[1] = HW_BUS_FREQ;
	length = sizeof(result);
	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
	{
		perror("getting bus frequency");
	}
	printf("Bus Frequency = %d hz\n", result);
}

void report_memory(void) {

//	FLBytesDataSizeFormatter* formatter = FLAutorelease([[FLBytesDataSizeFormatter alloc] init]);

	struct task_basic_info info;
	mach_msg_type_number_t size = sizeof(info);
	kern_return_t kerr = task_info(mach_task_self(),
								 TASK_BASIC_INFO,
								 (task_info_t)&info,
								 &size);
	if( kerr == KERN_SUCCESS ) 
	{
		if(!originalSize)
		{
			originalSize = info.resident_size;
		}
		if(info.resident_size > highWater)
		{
			highWater = info.resident_size;
		}
		
		FLLog(@"Memory in use:\n resident size %u\n increased by: %u\n highwater: %u", 
				info.resident_size,
				info.resident_size - originalSize,
				highWater);
	} 
	else 
	{
		NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
	}
}

static void print_free_memory () {
	mach_port_t host_port;
	mach_msg_type_number_t host_size;
	vm_size_t pagesize;
	
	host_port = mach_host_self();
	host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
	host_page_size(host_port, &pagesize);		 
 
	vm_statistics_data_t vm_stat;
			  
	if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
		NSLog(@"Failed to fetch vm statistics");
 
	// Stats in bytes 
	natural_t mem_used = (vm_stat.active_count +
						  vm_stat.inactive_count +
						  vm_stat.wire_count) * pagesize;
	natural_t mem_free = vm_stat.free_count * pagesize;
	natural_t mem_total = mem_used + mem_free;
	NSLog(@"used: %u free: %u total: %u", mem_used, mem_free, mem_total);
}
*/
#endif