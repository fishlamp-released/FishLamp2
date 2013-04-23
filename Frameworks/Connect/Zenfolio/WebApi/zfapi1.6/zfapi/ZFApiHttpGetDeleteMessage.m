//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetDeleteMessage.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpGetDeleteMessage.h"
#import "ZFDeleteMessageHttpGetIn.h"
#import "ZFDeleteMessageHttpGetOut.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpGetDeleteMessage


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFDeleteMessageHttpGetIn*) input
{
	if(!_input)
	{
		_input = [[ZFDeleteMessageHttpGetIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (ZFDeleteMessageHttpGetOut*) output
{
	if(!_output)
	{
		_output = [[ZFDeleteMessageHttpGetOut alloc] init];
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

+ (ZFApiHttpGetDeleteMessage*) apiHttpGetDeleteMessage
{
	return FLAutorelease([[ZFApiHttpGetDeleteMessage alloc] init]);
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
	return @"DeleteMessage";
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"input" withClass:[ZFDeleteMessageHttpGetIn class]];
		[describer setChildForIdentifier:@"output" withClass:[ZFDeleteMessageHttpGetOut class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFApiHttpGetDeleteMessage (ValueProperties) 
@end


@implementation ZFApiHttpGetDeleteMessage (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFDeleteMessageHttpGetIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (ZFDeleteMessageHttpGetOut*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFDeleteMessageHttpGetIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[ZFDeleteMessageHttpGetOut alloc] init];
	}
}
@end

