//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAccessUpdater.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAccessUpdater.h"
#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAccessUpdater


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

+ (ZFAccessUpdater*) accessUpdater
{
	return FLAutorelease([[ZFAccessUpdater alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAccessUpdater*)object).Viewers = FLCopyOrRetainObject(_Viewers);
	((ZFAccessUpdater*)object).IsDerived = FLCopyOrRetainObject(_IsDerived);
	((ZFAccessUpdater*)object).AccessMask = FLCopyOrRetainObject(_AccessMask);
	((ZFAccessUpdater*)object).Password = FLCopyOrRetainObject(_Password);
	((ZFAccessUpdater*)object).AccessType = FLCopyOrRetainObject(_AccessType);
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

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"AccessMask" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Password" withClass:[NSString class]];
		[describer setChildForIdentifier:@"AccessType" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Viewers" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Viewer" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"IsDerived" withClass:[FLBoolNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessMask" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Password" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Viewers" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsDerived" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAccessUpdater (ValueProperties) 

- (ZFApiAccessMask) AccessMaskValue
{
	return [[ZFApi1_6EnumLookup instance] apiAccessMaskFromString:self.AccessMask];
}

- (void) setAccessMaskValue:(ZFApiAccessMask) inEnumValue
{
	self.AccessMask = [[ZFApi1_6EnumLookup instance] stringFromApiAccessMask:inEnumValue];
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
@end

