//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCheckPrivilegeResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCheckPrivilegeResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCheckPrivilegeResponse


@synthesize CheckPrivilegeResult = _CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey
{
	return @"CheckPrivilegeResult";
}

+ (ZFCheckPrivilegeResponse*) checkPrivilegeResponse
{
	return FLAutorelease([[ZFCheckPrivilegeResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCheckPrivilegeResponse*)object).CheckPrivilegeResult = FLCopyOrRetainObject(_CheckPrivilegeResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_CheckPrivilegeResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CheckPrivilegeResult) [aCoder encodeObject:_CheckPrivilegeResult forKey:@"_CheckPrivilegeResult"];
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
		_CheckPrivilegeResult = FLRetain([aDecoder decodeObjectForKey:@"_CheckPrivilegeResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"CheckPrivilegeResult" withClass:[FLBoolNumber class] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CheckPrivilegeResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCheckPrivilegeResponse (ValueProperties) 

- (BOOL) CheckPrivilegeResultValue
{
	return [self.CheckPrivilegeResult boolValue];
}

- (void) setCheckPrivilegeResultValue:(BOOL) value
{
	self.CheckPrivilegeResult = [NSNumber numberWithBool:value];
}
@end

