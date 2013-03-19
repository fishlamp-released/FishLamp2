//
//  FLObjectInflator.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectInflator.h"
#import "FLObjectDescriber.h"
@implementation FLObjectInflator
- (id) initWithObjectDescriber:(FLObjectDescriber*) objectDescriber {
    return self;
}

@end

#if REFACTOR
@implementation FLObjectInflator

- (void) setValue:(id) value forKey:(id) key forObject:(id) object
{
	if(!_unboundedArrays)
	{
		[object setValue:value forKey:key];
	}
	else
	{
		NSString* arrayName = [_unboundedArrays objectForKey:key];
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
	if(!_unboundedArrays || [_unboundedArrays objectForKey:key] == nil)
	{
		return [object valueForKey:key];
	}
	return nil;
}

- (void) dealloc
{
	FLRelease(_unboundedArrays);
	FLSuperDealloc();
}

- (void) addUnboundedArraySetter:(NSString*) name arrayPropertyName:(NSString*) arrayName
{
	if(!_unboundedArrays)
	{
		_unboundedArrays = [[NSMutableDictionary alloc] init];
	}

	[_unboundedArrays setObject:arrayName forKey:name];
}

- (id) initWithObjectDescriber:(FLObjectDescriber*) objectDescriber
{
	if((self = [super init]))
	{
		for(FLObjectDescriber* desc in objectDescriber.objectDescribers.objectEnumerator)
		{
			if(desc.isUnboundedArray)
			{
				for(FLObjectDescriber* arrayItem in desc.arrayTypes)
				{
					[self addUnboundedArraySetter:arrayItem.propertyName arrayPropertyName:desc.propertyName];
				}
			}
		}
	
	}
	
	return self;
}

@end

@implementation NSObject (FLObjectInflator) 

- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object
{
	FLAssert_v(object == self, @"object should == self");
	[self setValue:value forKey:forKey];
}

- (id) valueForKey:(id) key forObject:(id) object
{
	FLAssert_v(object == self, @"object should == self");
	return [self valueForKey:key];
}

+ (FLObjectInflator*) sharedObjectInflator
{
	return nil;
}

- (id) objectInflator
{
	id shared = [[self class] sharedObjectInflator];

	return shared != nil ? shared : self;
}
@end
#endif