//
//	GtTextEditCellData.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditCellData.h"


@implementation GtTextEditCellData

@synthesize textInputTraits = m_traits;
@synthesize callback = m_callback;

- (void) dealloc
{
	GtRelease(m_callback);
	GtRelease(m_traits);
	GtSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
		m_traits = [[GtTextInputTraits alloc] init];
	}
	return self;
}

+ (GtTextEditCellData*) textEditCellData
{
	return GtReturnAutoreleased([[GtTextEditCellData alloc] init]);
}



@end

