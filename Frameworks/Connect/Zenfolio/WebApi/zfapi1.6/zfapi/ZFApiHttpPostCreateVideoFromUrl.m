//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostCreateVideoFromUrl.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpPostCreateVideoFromUrl.h"
#import "ZFCreateVideoFromUrlHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpPostCreateVideoFromUrl


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFCreateVideoFromUrlHttpPostIn*) input
{
	if(!_input)
	{
		_input = [[ZFCreateVideoFromUrlHttpPostIn alloc] init];
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

+ (ZFApiHttpPostCreateVideoFromUrl*) apiHttpPostCreateVideoFromUrl
{
	return FLAutorelease([[ZFApiHttpPostCreateVideoFromUrl alloc] init]);
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
	return @"CreateVideoFromUrl";
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"input" withClass:[ZFCreateVideoFromUrlHttpPostIn class]];
		[describer setChildForIdentifier:@"output" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFApiHttpPostCreateVideoFromUrl (ValueProperties) 

- (int) outputValue
{
	return [self.output intValue];
}

- (void) setOutputValue:(int) value
{
	self.output = [NSNumber numberWithInt:value];
}
@end


@implementation ZFApiHttpPostCreateVideoFromUrl (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFCreateVideoFromUrlHttpPostIn*) inputObject
{
	return _input;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFCreateVideoFromUrlHttpPostIn alloc] init];
	}
}
@end

