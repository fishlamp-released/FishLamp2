//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapAuthenticateVisitor.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfApiSoapAuthenticateVisitor.h"
#import "FLZfAuthenticateVisitor.h"
#import "FLZfAuthenticateVisitorResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfApiSoapAuthenticateVisitor


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (FLZfAuthenticateVisitor*) input
{
	if(!_input)
	{
		_input = [[FLZfAuthenticateVisitor alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (FLZfAuthenticateVisitorResponse*) output
{
	if(!_output)
	{
		_output = [[FLZfAuthenticateVisitorResponse alloc] init];
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

+ (FLZfApiSoapAuthenticateVisitor*) apiSoapAuthenticateVisitor
{
	return FLAutorelease([[FLZfApiSoapAuthenticateVisitor alloc] init]);
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
	return @"AuthenticateVisitor";
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"input" propertyClass:[FLZfAuthenticateVisitor class] propertyType:FLDataTypeObject] forPropertyName:@"input"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"output" propertyClass:[FLZfAuthenticateVisitorResponse class] propertyType:FLDataTypeObject] forPropertyName:@"output"];
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

@implementation FLZfApiSoapAuthenticateVisitor (ValueProperties) 
@end


@implementation FLZfApiSoapAuthenticateVisitor (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (FLZfAuthenticateVisitor*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (FLZfAuthenticateVisitorResponse*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[FLZfAuthenticateVisitor alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[FLZfAuthenticateVisitorResponse alloc] init];
	}
}
@end

