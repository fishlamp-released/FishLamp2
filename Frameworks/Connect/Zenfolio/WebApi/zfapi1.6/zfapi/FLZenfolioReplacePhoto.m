//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReplacePhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioReplacePhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioReplacePhoto


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
	((FLZenfolioReplacePhoto*)object).originalId = FLCopyOrRetainObject(_originalId);
	((FLZenfolioReplacePhoto*)object).replacedId = FLCopyOrRetainObject(_replacedId);
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

+ (FLZenfolioReplacePhoto*) replacePhoto
{
	return FLAutorelease([[FLZenfolioReplacePhoto alloc] init]);
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
		[s_describer addProperty:@"originalId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"replacedId" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"originalId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"replacedId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioReplacePhoto (ValueProperties) 

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

