//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReplacePhoto.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReplacePhoto.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFReplacePhoto


@synthesize originalId = _originalId;
@synthesize replacedId = _replacedId;

+ (NSString*) originalIdKey
{
	return @"originalId";
}

+ (NSString*) replacedIdKey
{
	return @"replacedId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFReplacePhoto*)object).originalId = FLCopyOrRetainObject(_originalId);
	((ZFReplacePhoto*)object).replacedId = FLCopyOrRetainObject(_replacedId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_originalId);
	FLRelease(_replacedId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_originalId) [aCoder encodeObject:_originalId forKey:@"_originalId"];
	if(_replacedId) [aCoder encodeObject:_replacedId forKey:@"_replacedId"];
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
		_originalId = FLRetain([aDecoder decodeObjectForKey:@"_originalId"]);
		_replacedId = FLRetain([aDecoder decodeObjectForKey:@"_replacedId"]);
	}
	return self;
}

+ (ZFReplacePhoto*) replacePhoto
{
	return FLAutorelease([[ZFReplacePhoto alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"originalId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"originalId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"replacedId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"replacedId"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"originalId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"replacedId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReplacePhoto (ValueProperties) 

- (int) originalIdValue
{
	return [self.originalId intValue];
}

- (void) setOriginalIdValue:(int) value
{
	self.originalId = [NSNumber numberWithInt:value];
}

- (int) replacedIdValue
{
	return [self.replacedId intValue];
}

- (void) setReplacedIdValue:(int) value
{
	self.replacedId = [NSNumber numberWithInt:value];
}
@end

