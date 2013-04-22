//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeleteGroupHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFDeleteGroupHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFDeleteGroupHttpGetIn


@synthesize groupId = _groupId;

+ (NSString*) groupIdKey
{
	return @"groupId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFDeleteGroupHttpGetIn*)object).groupId = FLCopyOrRetainObject(_groupId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_groupId);
	FLSuperDealloc();
}

+ (ZFDeleteGroupHttpGetIn*) deleteGroupHttpGetIn
{
	return FLAutorelease([[ZFDeleteGroupHttpGetIn alloc] init]);
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
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
		_groupId = FLRetain([aDecoder decodeObjectForKey:@"_groupId"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"groupId" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"groupId" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFDeleteGroupHttpGetIn (ValueProperties) 
@end

