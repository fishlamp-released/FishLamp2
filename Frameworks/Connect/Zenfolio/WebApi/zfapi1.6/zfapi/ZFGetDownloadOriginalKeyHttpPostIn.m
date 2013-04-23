//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetDownloadOriginalKeyHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetDownloadOriginalKeyHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetDownloadOriginalKeyHttpPostIn


@synthesize password = _password;
@synthesize photoIds = _photoIds;

+ (NSString*) passwordKey
{
	return @"password";
}

+ (NSString*) photoIdsKey
{
	return @"photoIds";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetDownloadOriginalKeyHttpPostIn*)object).photoIds = FLCopyOrRetainObject(_photoIds);
	((ZFGetDownloadOriginalKeyHttpPostIn*)object).password = FLCopyOrRetainObject(_password);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoIds);
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoIds) [aCoder encodeObject:_photoIds forKey:@"_photoIds"];
	if(_password) [aCoder encodeObject:_password forKey:@"_password"];
}

+ (ZFGetDownloadOriginalKeyHttpPostIn*) getDownloadOriginalKeyHttpPostIn
{
	return FLAutorelease([[ZFGetDownloadOriginalKeyHttpPostIn alloc] init]);
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
		_photoIds = [[aDecoder decodeObjectForKey:@"_photoIds"] mutableCopy];
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"photoIds" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"String" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"password" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoIds" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetDownloadOriginalKeyHttpPostIn (ValueProperties) 
@end

