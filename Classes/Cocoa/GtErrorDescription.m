//
//	GtErrorDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtErrorDescription.h"


@implementation GtErrorDescription

@synthesize title = m_title;
@synthesize description = m_description;
@synthesize error = m_error;

- (id) initWithTitle:(NSString*) title description:(NSString*) description
{
	if((self = [super init]))
	{
		self.title = title;
		self.description = description;
	}
	return self;
}

+ (GtErrorDescription*) errorDescription
{
	
    return GtReturnAutoreleased([[GtErrorDescription alloc] init]);
}
+ (GtErrorDescription*) errorDescriptionWithTitle:(NSString*) title description:(NSString*) description
{
	return GtReturnAutoreleased([[GtErrorDescription alloc] initWithTitle:title description:description]);
}

- (void) dealloc
{
	GtRelease(m_error);
	GtRelease(m_title);
	GtRelease(m_description);
	GtSuperDealloc();
}

@end