//
//	GtErrorDescriber.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtErrorDescriber.h"


@implementation GtErrorDescriberManager

GtSynthesizeSingleton(GtErrorDescriberManager);

- (id) init 
{
	if((self = [super init]))
	{
		m_describers = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_describers);
	GtSuperDealloc();
}

- (void) addErrorDescriber:(id<GtErrorDescriber>) describer
{
	[m_describers addObject:describer];
}

- (NSString*) describeError:(NSError*) error
{
	for(id<GtErrorDescriber> describer in [m_describers reverseObjectEnumerator])
	{
		if([describer willDescribeError:error])
		{
			NSString* description = [describer describeError:error];
			if(description != nil)
			{
				return description;
			}
		}
	}
	
	return nil;
}

@end
