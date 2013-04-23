//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCategory.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCategory.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCategory


@synthesize Code = _Code;
@synthesize DisplayName = _DisplayName;

+ (NSString*) CodeKey
{
	return @"Code";
}

+ (NSString*) DisplayNameKey
{
	return @"DisplayName";
}

+ (ZFCategory*) category
{
	return FLAutorelease([[ZFCategory alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCategory*)object).Code = FLCopyOrRetainObject(_Code);
	((ZFCategory*)object).DisplayName = FLCopyOrRetainObject(_DisplayName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Code);
	FLRelease(_DisplayName);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Code) [aCoder encodeObject:_Code forKey:@"_Code"];
	if(_DisplayName) [aCoder encodeObject:_DisplayName forKey:@"_DisplayName"];
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
		_Code = FLRetain([aDecoder decodeObjectForKey:@"_Code"]);
		_DisplayName = FLRetain([aDecoder decodeObjectForKey:@"_DisplayName"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"Code" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"DisplayName" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Code" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"DisplayName" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCategory (ValueProperties) 

- (int) CodeValue
{
	return [self.Code intValue];
}

- (void) setCodeValue:(int) value
{
	self.Code = [NSNumber numberWithInt:value];
}
@end

