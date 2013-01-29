//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAccessDescriptor.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAccessDescriptor.h"
#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFAccessDescriptor


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

+ (ZFAccessDescriptor*) accessDescriptor
{
	return FLAutorelease([[ZFAccessDescriptor alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAccessDescriptor*)object).RealmId = FLCopyOrRetainObject(_RealmId);
	((ZFAccessDescriptor*)object).SrcPasswordHint = FLCopyOrRetainObject(_SrcPasswordHint);
	((ZFAccessDescriptor*)object).password = FLCopyOrRetainObject(_password);
	((ZFAccessDescriptor*)object).IsDerived = FLCopyOrRetainObject(_IsDerived);
	((ZFAccessDescriptor*)object).Viewers = FLCopyOrRetainObject(_Viewers);
	((ZFAccessDescriptor*)object).protectedObjectClassName = FLCopyOrRetainObject(_protectedObjectClassName);
	((ZFAccessDescriptor*)object).AccessMask = FLCopyOrRetainObject(_AccessMask);
	((ZFAccessDescriptor*)object).PasswordHint = FLCopyOrRetainObject(_PasswordHint);
	((ZFAccessDescriptor*)object).AccessType = FLCopyOrRetainObject(_AccessType);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"RealmId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"RealmId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessType" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"AccessType"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"IsDerived" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"IsDerived"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessMask" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"AccessMask"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Viewers" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Viewer" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Viewers"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PasswordHint" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"PasswordHint"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"SrcPasswordHint" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"SrcPasswordHint"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"protectedObjectClassName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"protectedObjectClassName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"password" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"password"];
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

@implementation ZFAccessDescriptor (ValueProperties) 

- (int) RealmIdValue
{
	return [self.RealmId intValue];
}

- (void) setRealmIdValue:(int) value
{
	self.RealmId = [NSNumber numberWithInt:value];
}

- (ZFAccessType) AccessTypeValue
{
	return [[ZFApi1_6EnumLookup instance] accessTypeFromString:self.AccessType];
}

- (void) setAccessTypeValue:(ZFAccessType) inEnumValue
{
	self.AccessType = [[ZFApi1_6EnumLookup instance] stringFromAccessType:inEnumValue];
}

- (BOOL) IsDerivedValue
{
	return [self.IsDerived boolValue];
}

- (void) setIsDerivedValue:(BOOL) value
{
	self.IsDerived = [NSNumber numberWithBool:value];
}

- (ZFApiAccessMask) AccessMaskValue
{
	return [[ZFApi1_6EnumLookup instance] apiAccessMaskFromString:self.AccessMask];
}

- (void) setAccessMaskValue:(ZFApiAccessMask) inEnumValue
{
	self.AccessMask = [[ZFApi1_6EnumLookup instance] stringFromApiAccessMask:inEnumValue];
}
@end

