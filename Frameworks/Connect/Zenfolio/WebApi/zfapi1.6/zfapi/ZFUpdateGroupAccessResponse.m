//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroupAccessResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdateGroupAccessResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdateGroupAccessResponse


@synthesize UpdateGroupAccessResult = _UpdateGroupAccessResult;

+ (NSString*) UpdateGroupAccessResultKey
{
	return @"UpdateGroupAccessResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdateGroupAccessResponse*)object).UpdateGroupAccessResult = FLCopyOrRetainObject(_UpdateGroupAccessResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdateGroupAccessResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdateGroupAccessResult) [aCoder encodeObject:_UpdateGroupAccessResult forKey:@"_UpdateGroupAccessResult"];
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
		_UpdateGroupAccessResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdateGroupAccessResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"UpdateGroupAccessResult" withClass:[FLIntegerNumber class] ];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdateGroupAccessResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdateGroupAccessResponse*) updateGroupAccessResponse
{
	return FLAutorelease([[ZFUpdateGroupAccessResponse alloc] init]);
}

@end

@implementation ZFUpdateGroupAccessResponse (ValueProperties) 

- (int) UpdateGroupAccessResultValue
{
	return [self.UpdateGroupAccessResult intValue];
}

- (void) setUpdateGroupAccessResultValue:(int) value
{
	self.UpdateGroupAccessResult = [NSNumber numberWithInt:value];
}
@end

