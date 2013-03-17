//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreatePhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiSoapCreatePhotoSet.h"
#import "FLZenfolioCreatePhotoSet.h"
#import "FLZenfolioCreatePhotoSetResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioApiSoapCreatePhotoSet


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (FLZenfolioCreatePhotoSet*) input
{
	if(!_input)
	{
		_input = [[FLZenfolioCreatePhotoSet alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (FLZenfolioCreatePhotoSetResponse*) output
{
	if(!_output)
	{
		_output = [[FLZenfolioCreatePhotoSetResponse alloc] init];
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

+ (FLZenfolioApiSoapCreatePhotoSet*) apiSoapCreatePhotoSet
{
	return FLAutorelease([[FLZenfolioApiSoapCreatePhotoSet alloc] init]);
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
	return @"CreatePhotoSet";
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
		[s_describer addProperty:@"input" withClass:[FLZenfolioCreatePhotoSet class]];
		[s_describer addProperty:@"output" withClass:[FLZenfolioCreatePhotoSetResponse class]];
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

@implementation FLZenfolioApiSoapCreatePhotoSet (ValueProperties) 
@end


@implementation FLZenfolioApiSoapCreatePhotoSet (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (FLZenfolioCreatePhotoSet*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (FLZenfolioCreatePhotoSetResponse*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[FLZenfolioCreatePhotoSet alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[FLZenfolioCreatePhotoSetResponse alloc] init];
	}
}
@end

