//
//  GtObjectInflator.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectInflator.h"
#import "GtObjectDescriber.h"

@implementation GtObjectInflator

- (void) setValue:(id) value forKey:(id) key forObject:(id) object
{
	if(!m_unboundedArrays)
	{
		[object setValue:value forKey:key];
	}
	else
	{
		NSString* arrayName = [m_unboundedArrays objectForKey:key];
		if(arrayName)
		{
			NSMutableArray* array = [object valueForKey:arrayName];
			if(!array)
			{
				array = [NSMutableArray arrayWithObject:value];
				[object setValue:array forKey:arrayName];
			}
			else
			{
				[array addObject:value];
			}
		}
		else
		{
			[object setValue:value forKey:key];
		}
	}
}

- (id) valueForKey:(id) key forObject:(id) object
{
	if(!m_unboundedArrays || [m_unboundedArrays objectForKey:key] == nil)
	{
		return [object valueForKey:key];
	}
	return nil;
}

- (void) dealloc
{
	GtRelease(m_unboundedArrays);
	GtSuperDealloc();
}

- (void) addUnboundedArraySetter:(NSString*) name arrayPropertyName:(NSString*) arrayName
{
	if(!m_unboundedArrays)
	{
		m_unboundedArrays = [[NSMutableDictionary alloc] init];
	}

	[m_unboundedArrays setObject:arrayName forKey:name];
}

- (id) initWithObjectDescriber:(GtObjectDescriber*) objectDescriber
{
	if((self = [super init]))
	{
		for(GtPropertyDescription* desc in objectDescriber.propertyDescribers.objectEnumerator)
		{
			if(desc.isUnboundedArray)
			{
				for(GtPropertyDescription* arrayItem in desc.arrayTypes)
				{
					[self addUnboundedArraySetter:arrayItem.propertyName arrayPropertyName:desc.propertyName];
				}
			}
		}
	
	}
	
	return self;
}

@end

@implementation NSObject (GtObjectInflator) 

- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object
{
	GtAssert(object == self, @"object should == self");
	[self setValue:value forKey:forKey];
}

- (id) valueForKey:(id) key forObject:(id) object
{
	GtAssert(object == self, @"object should == self");
	return [self valueForKey:key];
}

+ (GtObjectInflator*) sharedObjectInflator
{
	return nil;
}

- (id) objectInflator
{
	id shared = [[self class] sharedObjectInflator];

	return shared != nil ? shared : self;
}
@end
