//
//	FLErrorDescriber.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	FLRelease(_describers);
	FLSuperDealloc();
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
