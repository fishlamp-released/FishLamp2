//
//  GtDictionaryData.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDictionaryDataContainer.h"


@implementation GtDictionaryDataContainer

@synthesize dictionary = m_dictionary;
@synthesize key = m_key;

- (id) initWithKey:(id) key
{
	if(self = [super init])
	{
		GtAssertNotNil(key);
	
		self.key = key;
	}
	
	return self;
}

- (id) initWithDictionaryAndKey:(id) dictionary key:(id) key
{
	if(self = [super init])
	{
		GtAssertNotNil(dictionary);
		GtAssertNotNil(key);
	
		self.dictionary = dictionary;
		self.key = key;
	}
	
	return self;
}

+ (GtDictionaryDataContainer*) dictionaryDataContainerWithKey:(id) key
{
	return [[GtAlloc(GtDictionaryDataContainer) initWithKey:key] autorelease];
}

+ (GtDictionaryDataContainer*) dictionaryDataContainer:(id) dictionary key:(id) key
{
	return [[GtAlloc(GtDictionaryDataContainer) initWithDictionaryAndKey:dictionary key:key] autorelease];
}

- (void) updateDataSource:(id) dataSource
{
	m_dictionary = dataSource;
}

- (void) dealloc
{
	GtRelease(m_key);
	[super dealloc];
}

- (void) setObject:(id) object
{
	[m_dictionary setObject:object forKey:m_key];
}

- (id) object
{
	return [m_dictionary objectForKey:m_key];
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"GtDictionaryDataContainer:\n Key: %@\n Value: %@", m_key, self.object];
}


@end
