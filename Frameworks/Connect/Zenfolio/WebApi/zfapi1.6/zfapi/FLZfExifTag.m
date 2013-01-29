//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfExifTag.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfExifTag.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfExifTag


@synthesize DisplayValue = _DisplayValue;
@synthesize Id = _Id;
@synthesize Value = _Value;

+ (NSString*) DisplayValueKey
{
	return @"DisplayValue";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) ValueKey
{
	return @"Value";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfExifTag*)object).Value = FLCopyOrRetainObject(_Value);
	((FLZfExifTag*)object).Id = FLCopyOrRetainObject(_Id);
	((FLZfExifTag*)object).DisplayValue = FLCopyOrRetainObject(_DisplayValue);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Id);
	FLRelease(_Value);
	FLRelease(_DisplayValue);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_Value) [aCoder encodeObject:_Value forKey:@"_Value"];
	if(_DisplayValue) [aCoder encodeObject:_DisplayValue forKey:@"_DisplayValue"];
}

+ (FLZfExifTag*) exifTag
{
	return FLAutorelease([[FLZfExifTag alloc] init]);
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
		_Id = FLRetain([aDecoder decodeObjectForKey:@"_Id"]);
		_Value = FLRetain([aDecoder decodeObjectForKey:@"_Value"]);
		_DisplayValue = FLRetain([aDecoder decodeObjectForKey:@"_DisplayValue"]);
	}
	return self;
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Id" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Id"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Value" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Value"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"DisplayValue" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"DisplayValue"];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Value" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"DisplayValue" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfExifTag (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}
@end

