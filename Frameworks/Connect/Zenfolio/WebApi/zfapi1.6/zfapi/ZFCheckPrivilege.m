//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCheckPrivilege.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCheckPrivilege.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCheckPrivilege


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

+ (ZFCheckPrivilege*) checkPrivilege
{
	return FLAutorelease([[ZFCheckPrivilege alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCheckPrivilege*)object).loginName = FLCopyOrRetainObject(_loginName);
	((ZFCheckPrivilege*)object).privilegeName = FLCopyOrRetainObject(_privilegeName);
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
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"loginName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"privilegeName" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
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

@implementation ZFCheckPrivilege (ValueProperties) 
@end

