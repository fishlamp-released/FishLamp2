//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReplacePhotoHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReplacePhotoHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFReplacePhotoHttpGetIn


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
	((ZFReplacePhotoHttpGetIn*)object).originalId = FLCopyOrRetainObject(_originalId);
	((ZFReplacePhotoHttpGetIn*)object).replacedId = FLCopyOrRetainObject(_replacedId);
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

+ (ZFReplacePhotoHttpGetIn*) replacePhotoHttpGetIn
{
	return FLAutorelease([[ZFReplacePhotoHttpGetIn alloc] init]);
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
		[s_describer addProperty:@"originalId" withClass:[NSString class]];
		[s_describer addProperty:@"replacedId" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"originalId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"replacedId" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReplacePhotoHttpGetIn (ValueProperties) 
@end

