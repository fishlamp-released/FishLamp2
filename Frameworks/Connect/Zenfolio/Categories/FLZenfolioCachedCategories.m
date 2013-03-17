//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCachedCategories.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCachedCategories.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLZenfolioCategory.h"

@implementation FLZenfolioCachedCategories


@synthesize arrayId = _arrayId;
@synthesize categoryArray = _categoryArray;

+ (NSString*) arrayIdKey
{
	return @"arrayId";
}

+ (NSString*) categoryArrayKey
{
	return @"categoryArray";
}

+ (FLZenfolioCachedCategories*) cachedCategories
{
	return FLAutorelease([[FLZenfolioCachedCategories alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCachedCategories*)object).arrayId = FLCopyOrRetainObject(_arrayId);
	((FLZenfolioCachedCategories*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_arrayId);
	FLRelease(_categoryArray);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_arrayId) [aCoder encodeObject:_arrayId forKey:@"_arrayId"];
	if(_categoryArray) [aCoder encodeObject:_categoryArray forKey:@"_categoryArray"];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super init]))
	{
		_arrayId = FLRetain([aDecoder decodeObjectForKey:@"_arrayId"]);
		_categoryArray = [[aDecoder decodeObjectForKey:@"_categoryArray"] mutableCopy];
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addProperty:@"arrayId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"categoryArray" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"category" propertyClass:[FLZenfolioCategory class]], nil]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"arrayId" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryArray" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCachedCategories (ValueProperties) 

- (NSInteger) arrayIdValue
{
	return [self.arrayId integerValue];
}

- (void) setArrayIdValue:(NSInteger) value
{
	self.arrayId = [NSNumber numberWithInteger:value];
}
@end

