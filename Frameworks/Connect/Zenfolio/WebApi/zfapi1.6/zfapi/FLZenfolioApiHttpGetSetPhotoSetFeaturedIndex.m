//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*) input
{
	if(!_input)
	{
		_input = [[FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut*) output
{
	if(!_output)
	{
		_output = [[FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut alloc] init];
	}
	return _output;
}

+ (NSString*) inputKey
{
	return @"input";
}

+ (NSString*) outputKey
{
	return @"output";
}

+ (FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex*) apiHttpGetSetPhotoSetFeaturedIndex
{
	return FLAutorelease([[FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex alloc] init]);
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
	return @"SetPhotoSetFeaturedIndex";
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
		[s_describer addProperty:@"input" withClass:[FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn class]];
		[s_describer addProperty:@"output" withClass:[FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex (ValueProperties) 
@end


@implementation FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut alloc] init];
	}
}
@end

