//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFResolveReferenceHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFResolveReferenceHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFResolveReferenceHttpGetIn


@synthesize loginName = _loginName;
@synthesize reference = _reference;

+ (NSString*) loginNameKey
{
	return @"loginName";
}

+ (NSString*) referenceKey
{
	return @"reference";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFResolveReferenceHttpGetIn*)object).loginName = FLCopyOrRetainObject(_loginName);
	((ZFResolveReferenceHttpGetIn*)object).reference = FLCopyOrRetainObject(_reference);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_loginName);
	FLRelease(_reference);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
	if(_reference) [aCoder encodeObject:_reference forKey:@"_reference"];
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
		_loginName = FLRetain([aDecoder decodeObjectForKey:@"_loginName"]);
		_reference = FLRetain([aDecoder decodeObjectForKey:@"_reference"]);
	}
	return self;
}

+ (ZFResolveReferenceHttpGetIn*) resolveReferenceHttpGetIn
{
	return FLAutorelease([[ZFResolveReferenceHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"loginName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"reference" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"loginName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"reference" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFResolveReferenceHttpGetIn (ValueProperties) 
@end

