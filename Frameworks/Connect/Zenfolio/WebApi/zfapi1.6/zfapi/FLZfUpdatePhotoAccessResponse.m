//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoAccessResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfUpdatePhotoAccessResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfUpdatePhotoAccessResponse


@synthesize UpdatePhotoAccessResult = _UpdatePhotoAccessResult;

+ (NSString*) UpdatePhotoAccessResultKey
{
	return @"UpdatePhotoAccessResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfUpdatePhotoAccessResponse*)object).UpdatePhotoAccessResult = FLCopyOrRetainObject(_UpdatePhotoAccessResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdatePhotoAccessResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdatePhotoAccessResult) [aCoder encodeObject:_UpdatePhotoAccessResult forKey:@"_UpdatePhotoAccessResult"];
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
		_UpdatePhotoAccessResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdatePhotoAccessResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UpdatePhotoAccessResult" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"UpdatePhotoAccessResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdatePhotoAccessResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZfUpdatePhotoAccessResponse*) updatePhotoAccessResponse
{
	return FLAutorelease([[FLZfUpdatePhotoAccessResponse alloc] init]);
}

@end

@implementation FLZfUpdatePhotoAccessResponse (ValueProperties) 

- (int) UpdatePhotoAccessResultValue
{
	return [self.UpdatePhotoAccessResult intValue];
}

- (void) setUpdatePhotoAccessResultValue:(int) value
{
	self.UpdatePhotoAccessResult = [NSNumber numberWithInt:value];
}
@end

