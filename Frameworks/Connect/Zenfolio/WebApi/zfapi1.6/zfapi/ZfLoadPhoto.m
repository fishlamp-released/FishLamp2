//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhoto.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhoto.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFLoadPhoto


@synthesize level = _level;
@synthesize photoId = _photoId;

+ (NSString*) levelKey
{
	return @"level";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFLoadPhoto*)object).level = FLCopyOrRetainObject(_level);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoId);
	FLRelease(_level);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_level) [aCoder encodeObject:_level forKey:@"_level"];
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
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_level = FLRetain([aDecoder decodeObjectForKey:@"_level"]);
	}
	return self;
}

+ (ZFLoadPhoto*) loadPhoto
{
	return FLAutorelease([[ZFLoadPhoto alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"photoId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"level" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"level"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhoto (ValueProperties) 

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}

- (ZFInformatonLevel) levelValue
{
	return [[ZFApi1_6EnumLookup instance] informatonLevelFromString:self.level];
}

- (void) setLevelValue:(ZFInformatonLevel) inEnumValue
{
	self.level = [[ZFApi1_6EnumLookup instance] stringFromInformatonLevel:inEnumValue];
}
@end

