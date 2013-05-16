//
//  GtCachedPhotoInfo.m
//  MyZen
//
//  Created by Mike Fullerton on 10/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtCachedPhotoData.h"

@implementation GtCachedPhotoData

GtSynthesize(photoData, setPhotoData, GtPhotoData, m_photoData);

- (id) initWithUrl:(NSString*) url
{
	if(self = [super init])
	{
		self.url = url;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_photoData);
	[super dealloc];
}


- (void) onConfigureDataDescriptors:(NSMutableDictionary *)dataDescriptors
{
	[super onConfigureDataDescriptors:dataDescriptors];

	GtDataDescriptor* descriptor = [dataDescriptors objectForKey:[GtCachedPhotoData urlKey]];
	descriptor.primaryKey = YES;
	descriptor.notNull = YES;
	descriptor.hasColumn = YES;
}

- (void) onSetCacheKey
{
	self.cacheKey = self.url;
}

@end
