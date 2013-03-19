//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAccessDescriptor.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioAccessDescriptor.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioAccessDescriptor


@synthesize AccessMask = _AccessMask;
@synthesize AccessType = _AccessType;
@synthesize IsDerived = _IsDerived;
@synthesize PasswordHint = _PasswordHint;
@synthesize RealmId = _RealmId;
@synthesize SrcPasswordHint = _SrcPasswordHint;
@synthesize Viewers = _Viewers;
@synthesize password = _password;
@synthesize protectedObjectClassName = _protectedObjectClassName;

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

+ (NSString*) PasswordHintKey
{
	return @"PasswordHint";
}

+ (NSString*) RealmIdKey
{
	return @"RealmId";
}

+ (NSString*) SrcPasswordHintKey
{
	return @"SrcPasswordHint";
}

+ (NSString*) ViewersKey
{
	return @"Viewers";
}

+ (NSString*) passwordKey
{
	return @"password";
}

+ (NSString*) protectedObjectClassNameKey
{
	return @"protectedObjectClassName";
}

+ (FLZenfolioAccessDescriptor*) accessDescriptor
{
	return FLAutorelease([[FLZenfolioAccessDescriptor alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioAccessDescriptor*)object).RealmId = FLCopyOrRetainObject(_RealmId);
	((FLZenfolioAccessDescriptor*)object).SrcPasswordHint = FLCopyOrRetainObject(_SrcPasswordHint);
	((FLZenfolioAccessDescriptor*)object).password = FLCopyOrRetainObject(_password);
	((FLZenfolioAccessDescriptor*)object).IsDerived = FLCopyOrRetainObject(_IsDerived);
	((FLZenfolioAccessDescriptor*)object).Viewers = FLCopyOrRetainObject(_Viewers);
	((FLZenfolioAccessDescriptor*)object).protectedObjectClassName = FLCopyOrRetainObject(_protectedObjectClassName);
	((FLZenfolioAccessDescriptor*)object).AccessMask = FLCopyOrRetainObject(_AccessMask);
	((FLZenfolioAccessDescriptor*)object).PasswordHint = FLCopyOrRetainObject(_PasswordHint);
	((FLZenfolioAccessDescriptor*)object).AccessType = FLCopyOrRetainObject(_AccessType);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_RealmId);
	FLRelease(_AccessType);
	FLRelease(_IsDerived);
	FLRelease(_AccessMask);
	FLRelease(_Viewers);
	FLRelease(_PasswordHint);
	FLRelease(_SrcPasswordHint);
	FLRelease(_protectedObjectClassName);
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_RealmId) [aCoder encodeObject:_RealmId forKey:@"_RealmId"];
	if(_AccessType) [aCoder encodeObject:_AccessType forKey:@"_AccessType"];
	if(_IsDerived) [aCoder encodeObject:_IsDerived forKey:@"_IsDerived"];
	if(_AccessMask) [aCoder encodeObject:_AccessMask forKey:@"_AccessMask"];
	if(_Viewers) [aCoder encodeObject:_Viewers forKey:@"_Viewers"];
	if(_PasswordHint) [aCoder encodeObject:_PasswordHint forKey:@"_PasswordHint"];
	if(_SrcPasswordHint) [aCoder encodeObject:_SrcPasswordHint forKey:@"_SrcPasswordHint"];
	if(_protectedObjectClassName) [aCoder encodeObject:_protectedObjectClassName forKey:@"_protectedObjectClassName"];
	if(_password) [aCoder encodeObject:_password forKey:@"_password"];
	[super encodeWithCoder:aCoder];
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
	if((self = [super initWithCoder:aDecoder]))
	{
		_RealmId = FLRetain([aDecoder decodeObjectForKey:@"_RealmId"]);
		_AccessType = FLRetain([aDecoder decodeObjectForKey:@"_AccessType"]);
		_IsDerived = FLRetain([aDecoder decodeObjectForKey:@"_IsDerived"]);
		_AccessMask = FLRetain([aDecoder decodeObjectForKey:@"_AccessMask"]);
		_Viewers = [[aDecoder decodeObjectForKey:@"_Viewers"] mutableCopy];
		_PasswordHint = FLRetain([aDecoder decodeObjectForKey:@"_PasswordHint"]);
		_SrcPasswordHint = FLRetain([aDecoder decodeObjectForKey:@"_SrcPasswordHint"]);
		_protectedObjectClassName = FLRetain([aDecoder decodeObjectForKey:@"_protectedObjectClassName"]);
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
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
		[s_describer addProperty:@"RealmId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"AccessType" withClass:[NSString class]];
		[s_describer addProperty:@"IsDerived" withClass:[FLBoolNumber class] ];
		[s_describer addProperty:@"AccessMask" withClass:[NSString class]];
		[s_describer addProperty:@"Viewers" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"Viewer" objectClass:[NSString class] ], nil]];
		[s_describer addProperty:@"PasswordHint" withClass:[NSString class]];
		[s_describer addProperty:@"SrcPasswordHint" withClass:[NSString class]];
		[s_describer addProperty:@"protectedObjectClassName" withClass:[NSString class]];
		[s_describer addProperty:@"password" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"RealmId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsDerived" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessMask" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Viewers" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PasswordHint" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SrcPasswordHint" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"protectedObjectClassName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioAccessDescriptor (ValueProperties) 

- (int) RealmIdValue
{
	return [self.RealmId intValue];
}

- (void) setRealmIdValue:(int) value
{
	self.RealmId = [NSNumber numberWithInt:value];
}

- (FLZenfolioAccessType) AccessTypeValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] accessTypeFromString:self.AccessType];
}

- (void) setAccessTypeValue:(FLZenfolioAccessType) inEnumValue
{
	self.AccessType = [[FLZenfolioApi1_6EnumLookup instance] stringFromAccessType:inEnumValue];
}

- (BOOL) IsDerivedValue
{
	return [self.IsDerived boolValue];
}

- (void) setIsDerivedValue:(BOOL) value
{
	self.IsDerived = [NSNumber numberWithBool:value];
}

- (FLZenfolioApiAccessMask) AccessMaskValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] apiAccessMaskFromString:self.AccessMask];
}

- (void) setAccessMaskValue:(FLZenfolioApiAccessMask) inEnumValue
{
	self.AccessMask = [[FLZenfolioApi1_6EnumLookup instance] stringFromApiAccessMask:inEnumValue];
}
@end

