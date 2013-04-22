//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticatePlain.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticatePlain.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthenticatePlain


@synthesize loginName = _loginName;
@synthesize password = _password;

+ (NSString*) loginNameKey
{
	return @"loginName";
}

+ (NSString*) passwordKey
{
	return @"password";
}

+ (ZFAuthenticatePlain*) authenticatePlain
{
	return FLAutorelease([[ZFAuthenticatePlain alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticatePlain*)object).loginName = FLCopyOrRetainObject(_loginName);
	((ZFAuthenticatePlain*)object).password = FLCopyOrRetainObject(_password);
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
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
	if(_password) [aCoder encodeObject:_password forKey:@"_password"];
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
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
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
		[describer setChildForIdentifier:@"password" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticatePlain (ValueProperties) 
@end

