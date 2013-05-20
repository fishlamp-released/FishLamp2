//
//	GtObjectParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectInflatorState.h"
#import <objc/runtime.h>

#import "NSObject+GtStreamableObject.h"

@implementation GtObjectInflatorState

@synthesize key = m_key;
@synthesize object = m_object;
@synthesize data = m_data;
@synthesize prev = m_prev;
#if NEW_PARSER
@synthesize objectDescriber = m_describer;
@synthesize parsedDataType = m_dataType;
#else
@synthesize type = m_type;
#endif

GtSynthesizeStructProperty(dataIsAttribute, setDataIsAttribute, BOOL, m_flags);

- (id) init
{
	if((self = [super init]))
	{
#if NEW_PARSER
		self.parsedDataType = GtDataTypeUnknown;
#endif
	}
	
	return self;
}


- (void) dealloc
{
#if NEW_PARSER
	GtRelease(m_describer);
#endif

	GtRelease(m_prev);
	GtRelease(m_object);
	GtRelease(m_key);
	GtRelease(m_data);
	GtSuperDealloc();
}

@end
