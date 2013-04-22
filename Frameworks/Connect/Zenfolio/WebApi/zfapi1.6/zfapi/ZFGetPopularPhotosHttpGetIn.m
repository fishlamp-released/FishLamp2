//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetPopularPhotosHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetPopularPhotosHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetPopularPhotosHttpGetIn


@synthesize limit = _limit;
@synthesize offset = _offset;

+ (NSString*) limitKey
{
	return @"limit";
}

+ (NSString*) offsetKey
{
	return @"offset";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetPopularPhotosHttpGetIn*)object).limit = FLCopyOrRetainObject(_limit);
	((ZFGetPopularPhotosHttpGetIn*)object).offset = FLCopyOrRetainObject(_offset);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_offset);
	FLRelease(_limit);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_offset) [aCoder encodeObject:_offset forKey:@"_offset"];
	if(_limit) [aCoder encodeObject:_limit forKey:@"_limit"];
}

+ (ZFGetPopularPhotosHttpGetIn*) getPopularPhotosHttpGetIn
{
	return FLAutorelease([[ZFGetPopularPhotosHttpGetIn alloc] init]);
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
		_offset = FLRetain([aDecoder decodeObjectForKey:@"_offset"]);
		_limit = FLRetain([aDecoder decodeObjectForKey:@"_limit"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"offset" withClass:[NSString class]];
		[describer setChildForIdentifier:@"limit" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetPopularPhotosHttpGetIn (ValueProperties) 
@end

