//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupHierarchyHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadGroupHierarchyHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadGroupHierarchyHttpPostIn


@synthesize loginName = _loginName;

+ (NSString*) loginNameKey
{
	return @"loginName";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadGroupHierarchyHttpPostIn*)object).loginName = FLCopyOrRetainObject(_loginName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_loginName);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
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
		_loginName = FLRetain([aDecoder decodeObjectForKey:@"_loginName"]);
	}
	return self;
}

+ (ZFLoadGroupHierarchyHttpPostIn*) loadGroupHierarchyHttpPostIn
{
	return FLAutorelease([[ZFLoadGroupHierarchyHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"loginName" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"loginName" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadGroupHierarchyHttpPostIn (ValueProperties) 
@end

