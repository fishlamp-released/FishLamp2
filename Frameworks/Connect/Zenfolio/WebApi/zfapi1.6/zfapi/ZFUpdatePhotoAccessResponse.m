//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoAccessResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdatePhotoAccessResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdatePhotoAccessResponse


@synthesize UpdatePhotoAccessResult = _UpdatePhotoAccessResult;

+ (NSString*) UpdatePhotoAccessResultKey
{
	return @"UpdatePhotoAccessResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdatePhotoAccessResponse*)object).UpdatePhotoAccessResult = FLCopyOrRetainObject(_UpdatePhotoAccessResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdatePhotoAccessResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdatePhotoAccessResult) [aCoder encodeObject:_UpdatePhotoAccessResult forKey:@"_UpdatePhotoAccessResult"];
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
		_UpdatePhotoAccessResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdatePhotoAccessResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"UpdatePhotoAccessResult" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdatePhotoAccessResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdatePhotoAccessResponse*) updatePhotoAccessResponse
{
	return FLAutorelease([[ZFUpdatePhotoAccessResponse alloc] init]);
}

@end

@implementation ZFUpdatePhotoAccessResponse (ValueProperties) 

- (int) UpdatePhotoAccessResultValue
{
	return [self.UpdatePhotoAccessResult intValue];
}

- (void) setUpdatePhotoAccessResultValue:(int) value
{
	self.UpdatePhotoAccessResult = [NSNumber numberWithInt:value];
}
@end

