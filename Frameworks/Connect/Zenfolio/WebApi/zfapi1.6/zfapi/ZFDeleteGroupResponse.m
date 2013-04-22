//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeleteGroupResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFDeleteGroupResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFDeleteGroupResponse



- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFDeleteGroupResponse*) deleteGroupResponse
{
	return FLAutorelease([[ZFDeleteGroupResponse alloc] init]);
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
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
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

	});
	return s_table;
}

@end

@implementation ZFDeleteGroupResponse (ValueProperties) 
@end

