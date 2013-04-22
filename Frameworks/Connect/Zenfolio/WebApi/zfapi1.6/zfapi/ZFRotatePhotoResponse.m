//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFRotatePhotoResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFRotatePhotoResponse.h"
#import "ZFPhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFRotatePhotoResponse


@synthesize RotatePhotoResult = _RotatePhotoResult;

+ (NSString*) RotatePhotoResultKey
{
	return @"RotatePhotoResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFRotatePhotoResponse*)object).RotatePhotoResult = FLCopyOrRetainObject(_RotatePhotoResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_RotatePhotoResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_RotatePhotoResult) [aCoder encodeObject:_RotatePhotoResult forKey:@"_RotatePhotoResult"];
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
		_RotatePhotoResult = FLRetain([aDecoder decodeObjectForKey:@"_RotatePhotoResult"]);
	}
	return self;
}

+ (ZFRotatePhotoResponse*) rotatePhotoResponse
{
	return FLAutorelease([[ZFRotatePhotoResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"RotatePhotoResult" withClass:[ZFPhoto class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"RotatePhotoResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFRotatePhotoResponse (ValueProperties) 
@end

