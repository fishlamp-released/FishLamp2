//
//  GtTextEditCellData.m
//  MyZen
//
//  Created by Mike Fullerton on 12/31/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTextEditCellData.h"


@implementation GtTextEditCellData

@synthesize textInputTraits = m_traits;

GtSynthesizeSetter(setTextInputTraits, GtTextInputTraits*, m_traits);
GtSynthesize(callback, setCallback, GtSimpleCallback, m_callback);

- (void) dealloc
{
    GtRelease(m_callback);
	GtRelease(m_traits);
	[super dealloc];
}

- (id) init
{
	if(self = [super init])
	{
		m_traits = [GtAlloc(GtTextInputTraits) init];
	}
	return self;
}

+ (GtTextEditCellData*) textEditCellData
{
	return [[GtAlloc(GtTextEditCellData) init] autorelease];
}



@end

