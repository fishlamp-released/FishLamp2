//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioExifTag.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioExifTag.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioExifTag


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
	((FLZenfolioExifTag*)object).Value = FLCopyOrRetainObject(_Value);
	((FLZenfolioExifTag*)object).Id = FLCopyOrRetainObject(_Id);
	((FLZenfolioExifTag*)object).DisplayValue = FLCopyOrRetainObject(_DisplayValue);
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

+ (FLZenfolioExifTag*) exifTag
{
	return FLAutorelease([[FLZenfolioExifTag alloc] init]);
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
		[s_describer addProperty:@"Id" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"Value" withClass:[NSString class]];
		[s_describer addProperty:@"DisplayValue" withClass:[NSString class]];
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

@implementation FLZenfolioExifTag (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}
@end

