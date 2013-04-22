//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSetAccessResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdatePhotoSetAccessResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdatePhotoSetAccessResponse


@synthesize UpdatePhotoSetAccessResult = _UpdatePhotoSetAccessResult;

+ (NSString*) UpdatePhotoSetAccessResultKey
{
	return @"UpdatePhotoSetAccessResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdatePhotoSetAccessResponse*)object).UpdatePhotoSetAccessResult = FLCopyOrRetainObject(_UpdatePhotoSetAccessResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdatePhotoSetAccessResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdatePhotoSetAccessResult) [aCoder encodeObject:_UpdatePhotoSetAccessResult forKey:@"_UpdatePhotoSetAccessResult"];
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
		_UpdatePhotoSetAccessResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdatePhotoSetAccessResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"UpdatePhotoSetAccessResult" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdatePhotoSetAccessResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdatePhotoSetAccessResponse*) updatePhotoSetAccessResponse
{
	return FLAutorelease([[ZFUpdatePhotoSetAccessResponse alloc] init]);
}

@end

@implementation ZFUpdatePhotoSetAccessResponse (ValueProperties) 

- (int) UpdatePhotoSetAccessResultValue
{
	return [self.UpdatePhotoSetAccessResult intValue];
}

- (void) setUpdatePhotoSetAccessResultValue:(int) value
{
	self.UpdatePhotoSetAccessResult = [NSNumber numberWithInt:value];
}
@end

