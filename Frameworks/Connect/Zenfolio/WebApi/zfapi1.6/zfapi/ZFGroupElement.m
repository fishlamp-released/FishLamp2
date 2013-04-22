//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroupElement.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGroupElement.h"
#import "ZFAccessDescriptor.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGroupElement


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
	((ZFGroupElement*)object).AccessDescriptor = FLCopyOrRetainObject(_AccessDescriptor);
	((ZFGroupElement*)object).HideBranding = FLCopyOrRetainObject(_HideBranding);
	((ZFGroupElement*)object).GroupIndex = FLCopyOrRetainObject(_GroupIndex);
	((ZFGroupElement*)object).Title = FLCopyOrRetainObject(_Title);
	((ZFGroupElement*)object).Owner = FLCopyOrRetainObject(_Owner);
	((ZFGroupElement*)object).Id = FLCopyOrRetainObject(_Id);
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

+ (ZFGroupElement*) groupElement
{
	return FLAutorelease([[ZFGroupElement alloc] init]);
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

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"Id" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"GroupIndex" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"Title" withClass:[NSString class]];
		[describer setChildForIdentifier:@"AccessDescriptor" withClass:[ZFAccessDescriptor class]];
		[describer setChildForIdentifier:@"Owner" withClass:[NSString class]];
		[describer setChildForIdentifier:@"HideBranding" withClass:[FLBoolNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GroupIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Title" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Owner" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"HideBranding" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGroupElement (ValueProperties) 

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

