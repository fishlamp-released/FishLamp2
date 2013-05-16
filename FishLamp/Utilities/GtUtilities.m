//
//  GtUtilities.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/3/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUtilities.h"
#import "GtFileUtilities.h"

@implementation GtUtilities

+ (void) initializeFishLamp
{

	GtSetRandomSeed();
	
	if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) 
	{
		GtLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}

}


@end


BOOL IsAtLeaskSdkVersion(int minVersion)
{
	static int checkResults = -1;
	if(checkResults == -1)
	{
		NSString* osVersion = [[UIDevice currentDevice] systemVersion];
		
		switch(minVersion)
		{
			case __IPHONE_3_0:
				checkResults = [osVersion characterAtIndex:0] == '3' ? YES : NO;
				break;
				
			default:
				checkResults = NO;
		}
	}
	return (BOOL) checkResults;
}
