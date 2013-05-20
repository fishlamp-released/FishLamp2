//
//  GtDevice.m
//  MyZen
//
//  Created by Mike Fullerton on 12/15/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDevice.h"
#import <sys/utsname.h>

@implementation UIDevice (Extras)

- (NSString*) machineName
{
	struct utsname u;
	uname(&u);
	return [NSString stringWithFormat:@"%s", u.machine];
}

@end
