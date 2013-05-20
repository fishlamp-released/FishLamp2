//
//	GtDataTypeManager.m
//	PackMule
//
//	Created by Mike Fullerton on 11/19/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDataTypeManager.h"

@implementation GtDataTypeManager

GtSynthesizeSingleton(GtDataTypeManager);

- (id) init
{
    if((self = [super init]))
    {
        m_dataTypes = [[NSMutableDictionary alloc] init];
    }
    
	return self;
}

- (void) dealloc
{
	GtRelease(m_dataTypes);
	GtSuperDealloc();
}

- (void) setDataTypes:(NSMutableDictionary*) dataTypes forClass:(Class) aClass
{
	@synchronized(self)
	{
		[m_dataTypes setObject:dataTypes forKey:NSStringFromClass(aClass)];
	}
}

- (NSMutableDictionary*) dataTypesForClass:(Class) aClass
{
	@synchronized(self)
	{
		NSMutableDictionary* dataTypes = [m_dataTypes objectForKey:aClass];
		if(!dataTypes)
		{
			dataTypes = [[NSMutableDictionary alloc] init];
			[m_dataTypes setObject:dataTypes forKey:NSStringFromClass(aClass)];
		//	  [aClass initializeDataTypes:dataTypes];
			GtRelease(dataTypes);
		}
		return dataTypes;
	}

	return nil; // for compiler.
}


@end
