//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGroupElement.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGroupElement.h"
#import "FLZenfolioAccessDescriptor.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioGroupElement


@synthesize AccessDescriptor = _AccessDescriptor;
@synthesize GroupIndex = _GroupIndex;
@synthesize HideBranding = _HideBranding;
@synthesize Id = _Id;
@synthesize Owner = _Owner;
@synthesize Title = _Title;

+ (NSString*) AccessDescriptorKey
{
	return @"AccessDescriptor";
}

+ (NSString*) GroupIndexKey
{
	return @"GroupIndex";
}

+ (NSString*) HideBrandingKey
{
	return @"HideBranding";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) OwnerKey
{
	return @"Owner";
}

+ (NSString*) TitleKey
{
	return @"Title";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGroupElement*)object).AccessDescriptor = FLCopyOrRetainObject(_AccessDescriptor);
	((FLZenfolioGroupElement*)object).HideBranding = FLCopyOrRetainObject(_HideBranding);
	((FLZenfolioGroupElement*)object).GroupIndex = FLCopyOrRetainObject(_GroupIndex);
	((FLZenfolioGroupElement*)object).Title = FLCopyOrRetainObject(_Title);
	((FLZenfolioGroupElement*)object).Owner = FLCopyOrRetainObject(_Owner);
	((FLZenfolioGroupElement*)object).Id = FLCopyOrRetainObject(_Id);
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
	FLRelease(_GroupIndex);
	FLRelease(_Title);
	FLRelease(_AccessDescriptor);
	FLRelease(_Owner);
	FLRelease(_HideBranding);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_GroupIndex) [aCoder encodeObject:_GroupIndex forKey:@"_GroupIndex"];
	if(_Title) [aCoder encodeObject:_Title forKey:@"_Title"];
	if(_AccessDescriptor) [aCoder encodeObject:_AccessDescriptor forKey:@"_AccessDescriptor"];
	if(_Owner) [aCoder encodeObject:_Owner forKey:@"_Owner"];
	if(_HideBranding) [aCoder encodeObject:_HideBranding forKey:@"_HideBranding"];
}

+ (FLZenfolioGroupElement*) groupElement
{
	return FLAutorelease([[FLZenfolioGroupElement alloc] init]);
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
		_GroupIndex = FLRetain([aDecoder decodeObjectForKey:@"_GroupIndex"]);
		_Title = FLRetain([aDecoder decodeObjectForKey:@"_Title"]);
		_AccessDescriptor = FLRetain([aDecoder decodeObjectForKey:@"_AccessDescriptor"]);
		_Owner = FLRetain([aDecoder decodeObjectForKey:@"_Owner"]);
		_HideBranding = FLRetain([aDecoder decodeObjectForKey:@"_HideBranding"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"GroupIndex" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"GroupIndex"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Title" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Title"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessDescriptor" propertyClass:[FLZenfolioAccessDescriptor class] propertyType:FLDataTypeObject] forPropertyName:@"AccessDescriptor"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Owner" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Owner"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"HideBranding" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"HideBranding"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GroupIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Title" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Owner" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"HideBranding" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGroupElement (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}

- (int) GroupIndexValue
{
	return [self.GroupIndex intValue];
}

- (void) setGroupIndexValue:(int) value
{
	self.GroupIndex = [NSNumber numberWithInt:value];
}

- (BOOL) HideBrandingValue
{
	return [self.HideBranding boolValue];
}

- (void) setHideBrandingValue:(BOOL) value
{
	self.HideBranding = [NSNumber numberWithBool:value];
}
@end

