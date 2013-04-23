//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByTextResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchPhotoByTextResponse.h"
#import "ZFPhotoResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchPhotoByTextResponse


@synthesize SearchPhotoByTextResult = _SearchPhotoByTextResult;

+ (NSString*) SearchPhotoByTextResultKey
{
	return @"SearchPhotoByTextResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFSearchPhotoByTextResponse*)object).SearchPhotoByTextResult = FLCopyOrRetainObject(_SearchPhotoByTextResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_SearchPhotoByTextResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_SearchPhotoByTextResult) [aCoder encodeObject:_SearchPhotoByTextResult forKey:@"_SearchPhotoByTextResult"];
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
		_SearchPhotoByTextResult = FLRetain([aDecoder decodeObjectForKey:@"_SearchPhotoByTextResult"]);
	}
	return self;
}

+ (ZFSearchPhotoByTextResponse*) searchPhotoByTextResponse
{
	return FLAutorelease([[ZFSearchPhotoByTextResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"SearchPhotoByTextResult" withClass:[ZFPhotoResult class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SearchPhotoByTextResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchPhotoByTextResponse (ValueProperties) 
@end

