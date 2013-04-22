//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCheckPrivilegeHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCheckPrivilegeHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCheckPrivilegeHttpPostIn


@synthesize loginName = _loginName;
@synthesize privilegeName = _privilegeName;

+ (NSString*) loginNameKey
{
	return @"loginName";
}

+ (NSString*) privilegeNameKey
{
	return @"privilegeName";
}

+ (ZFCheckPrivilegeHttpPostIn*) checkPrivilegeHttpPostIn
{
	return FLAutorelease([[ZFCheckPrivilegeHttpPostIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCheckPrivilegeHttpPostIn*)object).loginName = FLCopyOrRetainObject(_loginName);
	((ZFCheckPrivilegeHttpPostIn*)object).privilegeName = FLCopyOrRetainObject(_privilegeName);
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
	FLRelease(_privilegeName);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
	if(_privilegeName) [aCoder encodeObject:_privilegeName forKey:@"_privilegeName"];
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
		_privilegeName = FLRetain([aDecoder decodeObjectForKey:@"_privilegeName"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"loginName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"privilegeName" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"privilegeName" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCheckPrivilegeHttpPostIn (ValueProperties) 
@end

