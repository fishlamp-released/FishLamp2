//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadPhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiSoapLoadPhoto.h"
#import "FLZenfolioLoadPhoto.h"
#import "FLZenfolioLoadPhotoResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioApiSoapLoadPhoto


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (FLZenfolioLoadPhoto*) input
{
	if(!_input)
	{
		_input = [[FLZenfolioLoadPhoto alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (FLZenfolioLoadPhotoResponse*) output
{
	if(!_output)
	{
		_output = [[FLZenfolioLoadPhotoResponse alloc] init];
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

+ (FLZenfolioApiSoapLoadPhoto*) apiSoapLoadPhoto
{
	return FLAutorelease([[FLZenfolioApiSoapLoadPhoto alloc] init]);
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
	return @"LoadPhoto";
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addProperty:@"input" withClass:[FLZenfolioLoadPhoto class]];
		[s_describer addProperty:@"output" withClass:[FLZenfolioLoadPhotoResponse class]];
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

@implementation FLZenfolioApiSoapLoadPhoto (ValueProperties) 
@end


@implementation FLZenfolioApiSoapLoadPhoto (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (FLZenfolioLoadPhoto*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (FLZenfolioLoadPhotoResponse*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[FLZenfolioLoadPhoto alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[FLZenfolioLoadPhotoResponse alloc] init];
	}
}
@end

