//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoResponse.h"
#import "ZFPhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoResponse


@synthesize LoadPhotoResult = _LoadPhotoResult;

+ (NSString*) LoadPhotoResultKey
{
	return @"LoadPhotoResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhotoResponse*)object).LoadPhotoResult = FLCopyOrRetainObject(_LoadPhotoResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPhotoResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPhotoResult) [aCoder encodeObject:_LoadPhotoResult forKey:@"_LoadPhotoResult"];
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
		_LoadPhotoResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadPhotoResult"]);
	}
	return self;
}

+ (ZFLoadPhotoResponse*) loadPhotoResponse
{
	return FLAutorelease([[ZFLoadPhotoResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"LoadPhotoResult" withClass:[ZFPhoto class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPhotoResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoResponse (ValueProperties) 
@end

