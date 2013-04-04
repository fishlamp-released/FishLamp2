//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFFavoritesSet.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFFavoritesSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFFavoritesSet


@synthesize ChangeNumber = _ChangeNumber;
@synthesize Id = _Id;
@synthesize IsShared = _IsShared;
@synthesize Name = _Name;
@synthesize SharedOn = _SharedOn;
@synthesize SharerEmail = _SharerEmail;
@synthesize SharerMessage = _SharerMessage;
@synthesize SharerName = _SharerName;

+ (NSString*) ChangeNumberKey
{
	return @"ChangeNumber";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) IsSharedKey
{
	return @"IsShared";
}

+ (NSString*) NameKey
{
	return @"Name";
}

+ (NSString*) SharedOnKey
{
	return @"SharedOn";
}

+ (NSString*) SharerEmailKey
{
	return @"SharerEmail";
}

+ (NSString*) SharerMessageKey
{
	return @"SharerMessage";
}

+ (NSString*) SharerNameKey
{
	return @"SharerName";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFFavoritesSet*)object).IsShared = FLCopyOrRetainObject(_IsShared);
	((ZFFavoritesSet*)object).ChangeNumber = FLCopyOrRetainObject(_ChangeNumber);
	((ZFFavoritesSet*)object).Id = FLCopyOrRetainObject(_Id);
	((ZFFavoritesSet*)object).SharedOn = FLCopyOrRetainObject(_SharedOn);
	((ZFFavoritesSet*)object).SharerName = FLCopyOrRetainObject(_SharerName);
	((ZFFavoritesSet*)object).Name = FLCopyOrRetainObject(_Name);
	((ZFFavoritesSet*)object).SharerEmail = FLCopyOrRetainObject(_SharerEmail);
	((ZFFavoritesSet*)object).SharerMessage = FLCopyOrRetainObject(_SharerMessage);
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
	FLRelease(_ChangeNumber);
	FLRelease(_Name);
	FLRelease(_IsShared);
	FLRelease(_SharedOn);
	FLRelease(_SharerName);
	FLRelease(_SharerEmail);
	FLRelease(_SharerMessage);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_ChangeNumber) [aCoder encodeObject:_ChangeNumber forKey:@"_ChangeNumber"];
	if(_Name) [aCoder encodeObject:_Name forKey:@"_Name"];
	if(_IsShared) [aCoder encodeObject:_IsShared forKey:@"_IsShared"];
	if(_SharedOn) [aCoder encodeObject:_SharedOn forKey:@"_SharedOn"];
	if(_SharerName) [aCoder encodeObject:_SharerName forKey:@"_SharerName"];
	if(_SharerEmail) [aCoder encodeObject:_SharerEmail forKey:@"_SharerEmail"];
	if(_SharerMessage) [aCoder encodeObject:_SharerMessage forKey:@"_SharerMessage"];
}

+ (ZFFavoritesSet*) favoritesSet
{
	return FLAutorelease([[ZFFavoritesSet alloc] init]);
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
		_ChangeNumber = FLRetain([aDecoder decodeObjectForKey:@"_ChangeNumber"]);
		_Name = FLRetain([aDecoder decodeObjectForKey:@"_Name"]);
		_IsShared = FLRetain([aDecoder decodeObjectForKey:@"_IsShared"]);
		_SharedOn = FLRetain([aDecoder decodeObjectForKey:@"_SharedOn"]);
		_SharerName = FLRetain([aDecoder decodeObjectForKey:@"_SharerName"]);
		_SharerEmail = FLRetain([aDecoder decodeObjectForKey:@"_SharerEmail"]);
		_SharerMessage = FLRetain([aDecoder decodeObjectForKey:@"_SharerMessage"]);
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
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addChildDescriberWithName:@"Id" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"ChangeNumber" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Name" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"IsShared" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"SharedOn" withClass:[NSDate class]];
		[s_describer addChildDescriberWithName:@"SharerName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"SharerEmail" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"SharerMessage" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ChangeNumber" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsShared" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SharedOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SharerName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SharerEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SharerMessage" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFFavoritesSet (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}

- (int) ChangeNumberValue
{
	return [self.ChangeNumber intValue];
}

- (void) setChangeNumberValue:(int) value
{
	self.ChangeNumber = [NSNumber numberWithInt:value];
}

- (BOOL) IsSharedValue
{
	return [self.IsShared boolValue];
}

- (void) setIsSharedValue:(BOOL) value
{
	self.IsShared = [NSNumber numberWithBool:value];
}
@end

