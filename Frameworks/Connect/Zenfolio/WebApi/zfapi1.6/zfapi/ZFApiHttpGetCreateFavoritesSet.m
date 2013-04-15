//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetCreateFavoritesSet.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpGetCreateFavoritesSet.h"
#import "ZFCreateFavoritesSetHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpGetCreateFavoritesSet


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFCreateFavoritesSetHttpGetIn*) input
{
	if(!_input)
	{
		_input = [[ZFCreateFavoritesSetHttpGetIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

+ (NSString*) inputKey
{
	return @"input";
}

+ (NSString*) outputKey
{
	return @"output";
}

+ (ZFApiHttpGetCreateFavoritesSet*) apiHttpGetCreateFavoritesSet
{
	return FLAutorelease([[ZFApiHttpGetCreateFavoritesSet alloc] init]);
}

- (void) dealloc
{
	FLRelease(_input);
	FLRelease(_output);
	FLSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (NSString*) operationName
{
	return @"CreateFavoritesSet";
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer setChildForIdentifier:@"input" withClass:[ZFCreateFavoritesSetHttpGetIn class]];
		[s_describer setChildForIdentifier:@"output" withClass:[FLIntegerNumber class] ];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFApiHttpGetCreateFavoritesSet (ValueProperties) 

- (int) outputValue
{
	return [self.output intValue];
}

- (void) setOutputValue:(int) value
{
	self.output = [NSNumber numberWithInt:value];
}
@end


@implementation ZFApiHttpGetCreateFavoritesSet (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFCreateFavoritesSetHttpGetIn*) inputObject
{
	return _input;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFCreateFavoritesSetHttpGetIn alloc] init];
	}
}
@end

