//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFResolveResult.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFResolveResult.h"
#import "ZFGroup.h"
#import "ZFPhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFResolveResult


@synthesize Group = _Group;
@synthesize PhotoSet = _PhotoSet;

+ (NSString*) GroupKey
{
	return @"Group";
}

+ (NSString*) PhotoSetKey
{
	return @"PhotoSet";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFResolveResult*)object).Group = FLCopyOrRetainObject(_Group);
	((ZFResolveResult*)object).PhotoSet = FLCopyOrRetainObject(_PhotoSet);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Group);
	FLRelease(_PhotoSet);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Group) [aCoder encodeObject:_Group forKey:@"_Group"];
	if(_PhotoSet) [aCoder encodeObject:_PhotoSet forKey:@"_PhotoSet"];
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
		_Group = FLRetain([aDecoder decodeObjectForKey:@"_Group"]);
		_PhotoSet = FLRetain([aDecoder decodeObjectForKey:@"_PhotoSet"]);
	}
	return self;
}

+ (ZFResolveResult*) resolveResult
{
	return FLAutorelease([[ZFResolveResult alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"Group" withClass:[ZFGroup class]];
		[describer setChildForIdentifier:@"PhotoSet" withClass:[ZFPhotoSet class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Group" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoSet" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFResolveResult (ValueProperties) 
@end

