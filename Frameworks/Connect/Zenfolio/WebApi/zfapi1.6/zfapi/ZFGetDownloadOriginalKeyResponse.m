//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetDownloadOriginalKeyResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetDownloadOriginalKeyResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetDownloadOriginalKeyResponse


@synthesize GetDownloadOriginalKeyResult = _GetDownloadOriginalKeyResult;

+ (NSString*) GetDownloadOriginalKeyResultKey
{
	return @"GetDownloadOriginalKeyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetDownloadOriginalKeyResponse*)object).GetDownloadOriginalKeyResult = FLCopyOrRetainObject(_GetDownloadOriginalKeyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetDownloadOriginalKeyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetDownloadOriginalKeyResult) [aCoder encodeObject:_GetDownloadOriginalKeyResult forKey:@"_GetDownloadOriginalKeyResult"];
}

+ (ZFGetDownloadOriginalKeyResponse*) getDownloadOriginalKeyResponse
{
	return FLAutorelease([[ZFGetDownloadOriginalKeyResponse alloc] init]);
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
		_GetDownloadOriginalKeyResult = FLRetain([aDecoder decodeObjectForKey:@"_GetDownloadOriginalKeyResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"GetDownloadOriginalKeyResult" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetDownloadOriginalKeyResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetDownloadOriginalKeyResponse (ValueProperties) 
@end

