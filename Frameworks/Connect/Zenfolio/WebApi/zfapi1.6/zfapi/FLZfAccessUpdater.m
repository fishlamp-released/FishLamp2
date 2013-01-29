//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAccessUpdater.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfAccessUpdater.h"
#import "FLZfApi1_6Enums.h"
#import "FLZfApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfAccessUpdater


@synthesize AccessMask = _AccessMask;
@synthesize AccessType = _AccessType;
@synthesize IsDerived = _IsDerived;
@synthesize Password = _Password;
@synthesize Viewers = _Viewers;

+ (NSString*) AccessMaskKey
{
	return @"AccessMask";
}

+ (NSString*) AccessTypeKey
{
	return @"AccessType";
}

+ (NSString*) IsDerivedKey
{
	return @"IsDerived";
}

+ (NSString*) PasswordKey
{
	return @"Password";
}

+ (NSString*) ViewersKey
{
	return @"Viewers";
}

+ (FLZfAccessUpdater*) accessUpdater
{
	return FLAutorelease([[FLZfAccessUpdater alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfAccessUpdater*)object).Viewers = FLCopyOrRetainObject(_Viewers);
	((FLZfAccessUpdater*)object).IsDerived = FLCopyOrRetainObject(_IsDerived);
	((FLZfAccessUpdater*)object).AccessMask = FLCopyOrRetainObject(_AccessMask);
	((FLZfAccessUpdater*)object).Password = FLCopyOrRetainObject(_Password);
	((FLZfAccessUpdater*)object).AccessType = FLCopyOrRetainObject(_AccessType);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_AccessMask);
	FLRelease(_Password);
	FLRelease(_AccessType);
	FLRelease(_Viewers);
	FLRelease(_IsDerived);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_AccessMask) [aCoder encodeObject:_AccessMask forKey:@"_AccessMask"];
	if(_Password) [aCoder encodeObject:_Password forKey:@"_Password"];
	if(_AccessType) [aCoder encodeObject:_AccessType forKey:@"_AccessType"];
	if(_Viewers) [aCoder encodeObject:_Viewers forKey:@"_Viewers"];
	if(_IsDerived) [aCoder encodeObject:_IsDerived forKey:@"_IsDerived"];
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
		_AccessMask = FLRetain([aDecoder decodeObjectForKey:@"_AccessMask"]);
		_Password = FLRetain([aDecoder decodeObjectForKey:@"_Password"]);
		_AccessType = FLRetain([aDecoder decodeObjectForKey:@"_AccessType"]);
		_Viewers = [[aDecoder decodeObjectForKey:@"_Viewers"] mutableCopy];
		_IsDerived = FLRetain([aDecoder decodeObjectForKey:@"_IsDerived"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessMask" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"AccessMask"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Password" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Password"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessType" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"AccessType"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Viewers" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Viewer" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Viewers"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"IsDerived" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"IsDerived"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessMask" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Password" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Viewers" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsDerived" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfAccessUpdater (ValueProperties) 

- (FLZfApiAccessMask) AccessMaskValue
{
	return [[FLZfApi1_6EnumLookup instance] apiAccessMaskFromString:self.AccessMask];
}

- (void) setAccessMaskValue:(FLZfApiAccessMask) inEnumValue
{
	self.AccessMask = [[FLZfApi1_6EnumLookup instance] stringFromApiAccessMask:inEnumValue];
}

- (FLZfAccessType) AccessTypeValue
{
	return [[FLZfApi1_6EnumLookup instance] accessTypeFromString:self.AccessType];
}

- (void) setAccessTypeValue:(FLZfAccessType) inEnumValue
{
	self.AccessType = [[FLZfApi1_6EnumLookup instance] stringFromAccessType:inEnumValue];
}

- (BOOL) IsDerivedValue
{
	return [self.IsDerived boolValue];
}

- (void) setIsDerivedValue:(BOOL) value
{
	self.IsDerived = [NSNumber numberWithBool:value];
}
@end

