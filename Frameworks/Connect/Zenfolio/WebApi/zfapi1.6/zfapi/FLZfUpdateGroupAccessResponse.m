//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdateGroupAccessResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfUpdateGroupAccessResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfUpdateGroupAccessResponse


@synthesize UpdateGroupAccessResult = _UpdateGroupAccessResult;

+ (NSString*) UpdateGroupAccessResultKey
{
	return @"UpdateGroupAccessResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfUpdateGroupAccessResponse*)object).UpdateGroupAccessResult = FLCopyOrRetainObject(_UpdateGroupAccessResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdateGroupAccessResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdateGroupAccessResult) [aCoder encodeObject:_UpdateGroupAccessResult forKey:@"_UpdateGroupAccessResult"];
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
		_UpdateGroupAccessResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdateGroupAccessResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UpdateGroupAccessResult" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"UpdateGroupAccessResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdateGroupAccessResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZfUpdateGroupAccessResponse*) updateGroupAccessResponse
{
	return FLAutorelease([[FLZfUpdateGroupAccessResponse alloc] init]);
}

@end

@implementation FLZfUpdateGroupAccessResponse (ValueProperties) 

- (int) UpdateGroupAccessResultValue
{
	return [self.UpdateGroupAccessResult intValue];
}

- (void) setUpdateGroupAccessResultValue:(int) value
{
	self.UpdateGroupAccessResult = [NSNumber numberWithInt:value];
}
@end

