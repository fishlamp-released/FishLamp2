//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetRecentSets.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGetRecentSets.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioGetRecentSets


@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize type = _type;

+ (NSString*) limitKey
{
	return @"limit";
}

+ (NSString*) offsetKey
{
	return @"offset";
}

+ (NSString*) typeKey
{
	return @"type";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGetRecentSets*)object).type = FLCopyOrRetainObject(_type);
	((FLZenfolioGetRecentSets*)object).limit = FLCopyOrRetainObject(_limit);
	((FLZenfolioGetRecentSets*)object).offset = FLCopyOrRetainObject(_offset);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_type);
	FLRelease(_offset);
	FLRelease(_limit);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_type) [aCoder encodeObject:_type forKey:@"_type"];
	if(_offset) [aCoder encodeObject:_offset forKey:@"_offset"];
	if(_limit) [aCoder encodeObject:_limit forKey:@"_limit"];
}

+ (FLZenfolioGetRecentSets*) getRecentSets
{
	return FLAutorelease([[FLZenfolioGetRecentSets alloc] init]);
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
		_type = FLRetain([aDecoder decodeObjectForKey:@"_type"]);
		_offset = FLRetain([aDecoder decodeObjectForKey:@"_offset"]);
		_limit = FLRetain([aDecoder decodeObjectForKey:@"_limit"]);
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
		[s_describer addProperty:@"type" withClass:[NSString class]];
		[s_describer addProperty:@"offset" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"limit" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGetRecentSets (ValueProperties) 

- (FLZenfolioPhotoSetType) typeValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] photoSetTypeFromString:self.type];
}

- (void) setTypeValue:(FLZenfolioPhotoSetType) inEnumValue
{
	self.type = [[FLZenfolioApi1_6EnumLookup instance] stringFromPhotoSetType:inEnumValue];
}

- (int) offsetValue
{
	return [self.offset intValue];
}

- (void) setOffsetValue:(int) value
{
	self.offset = [NSNumber numberWithInt:value];
}

- (int) limitValue
{
	return [self.limit intValue];
}

- (void) setLimitValue:(int) value
{
	self.limit = [NSNumber numberWithInt:value];
}
@end

