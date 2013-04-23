//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoFromUrlResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreatePhotoFromUrlResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreatePhotoFromUrlResponse


@synthesize CreatePhotoFromUrlResult = _CreatePhotoFromUrlResult;

+ (NSString*) CreatePhotoFromUrlResultKey
{
	return @"CreatePhotoFromUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreatePhotoFromUrlResponse*)object).CreatePhotoFromUrlResult = FLCopyOrRetainObject(_CreatePhotoFromUrlResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreatePhotoFromUrlResponse*) createPhotoFromUrlResponse
{
	return FLAutorelease([[ZFCreatePhotoFromUrlResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreatePhotoFromUrlResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreatePhotoFromUrlResult) [aCoder encodeObject:_CreatePhotoFromUrlResult forKey:@"_CreatePhotoFromUrlResult"];
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
		_CreatePhotoFromUrlResult = FLRetain([aDecoder decodeObjectForKey:@"_CreatePhotoFromUrlResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"CreatePhotoFromUrlResult" withClass:[FLIntegerNumber class] ];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreatePhotoFromUrlResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreatePhotoFromUrlResponse (ValueProperties) 

- (int) CreatePhotoFromUrlResultValue
{
	return [self.CreatePhotoFromUrlResult intValue];
}

- (void) setCreatePhotoFromUrlResultValue:(int) value
{
	self.CreatePhotoFromUrlResult = [NSNumber numberWithInt:value];
}
@end

