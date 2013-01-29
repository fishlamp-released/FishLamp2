//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoFromUrlResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfCreatePhotoFromUrlResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfCreatePhotoFromUrlResponse


@synthesize CreatePhotoFromUrlResult = _CreatePhotoFromUrlResult;

+ (NSString*) CreatePhotoFromUrlResultKey
{
	return @"CreatePhotoFromUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfCreatePhotoFromUrlResponse*)object).CreatePhotoFromUrlResult = FLCopyOrRetainObject(_CreatePhotoFromUrlResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZfCreatePhotoFromUrlResponse*) createPhotoFromUrlResponse
{
	return FLAutorelease([[FLZfCreatePhotoFromUrlResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreatePhotoFromUrlResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreatePhotoFromUrlResult) [aCoder encodeObject:_CreatePhotoFromUrlResult forKey:@"_CreatePhotoFromUrlResult"];
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
		_CreatePhotoFromUrlResult = FLRetain([aDecoder decodeObjectForKey:@"_CreatePhotoFromUrlResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CreatePhotoFromUrlResult" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"CreatePhotoFromUrlResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreatePhotoFromUrlResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfCreatePhotoFromUrlResponse (ValueProperties) 

- (int) CreatePhotoFromUrlResultValue
{
	return [self.CreatePhotoFromUrlResult intValue];
}

- (void) setCreatePhotoFromUrlResultValue:(int) value
{
	self.CreatePhotoFromUrlResult = [NSNumber numberWithInt:value];
}
@end

