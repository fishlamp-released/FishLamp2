//
//	FLErrorDescriber.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLErrorDescriber.h"


@implementation FLErrorDescriberManager

FLSynthesizeSingleton(FLErrorDescriberManager);

- (id) init 
{
	if((self = [super init]))
	{
		_describers = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	mrc_release_(_describers);
	super_dealloc_();
}

- (void) addErrorDescriber:(id<FLErrorDescriber>) describer
{
	[_describers addObject:describer];
}

- (NSString*) describeError:(NSError*) error
{
	for(id<FLErrorDescriber> describer in [_describers reverseObjectEnumerator])
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
