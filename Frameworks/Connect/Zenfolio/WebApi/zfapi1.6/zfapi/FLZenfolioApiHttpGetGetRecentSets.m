//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetRecentSets.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiHttpGetGetRecentSets.h"
#import "FLZenfolioGetRecentSetsHttpGetIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLZenfolioPhotoSet.h"

@implementation FLZenfolioApiHttpGetGetRecentSets


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (FLZenfolioGetRecentSetsHttpGetIn*) input
{
	if(!_input)
	{
		_input = [[FLZenfolioGetRecentSetsHttpGetIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (NSMutableArray*) output
{
	if(!_output)
	{
		_output = [[NSMutableArray alloc] init];
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

+ (FLZenfolioApiHttpGetGetRecentSets*) apiHttpGetGetRecentSets
{
	return FLAutorelease([[FLZenfolioApiHttpGetGetRecentSets alloc] init]);
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
	return @"GetRecentSets";
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"input" propertyClass:[FLZenfolioGetRecentSetsHttpGetIn class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"output" propertyClass:[NSMutableArray class]  arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"PhotoSet" propertyClass:[FLZenfolioPhotoSet class]], nil] isUnboundedArray:NO] ];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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

@implementation FLZenfolioApiHttpGetGetRecentSets (ValueProperties) 
@end


@implementation FLZenfolioApiHttpGetGetRecentSets (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (FLZenfolioGetRecentSetsHttpGetIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (NSMutableArray*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[FLZenfolioGetRecentSetsHttpGetIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[NSMutableArray alloc] init];
	}
}
@end
