//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadGroupHierarchy.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads group hierarchy of the specified user. <A href="/zf/help/api/ref/methods/loadgrouphierarchy">More...</A>
*/



@class FLZfLoadGroupHierarchy;
@class FLZfLoadGroupHierarchyResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadGroupHierarchy
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadGroupHierarchy : NSObject{ 
@private
	FLZfLoadGroupHierarchy* _input;
	FLZfLoadGroupHierarchyResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadGroupHierarchy* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadGroupHierarchyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadGroupHierarchy*) apiSoapLoadGroupHierarchy; 

@end

@interface FLZfApiSoapLoadGroupHierarchy (ValueProperties) 
@end


@interface FLZfApiSoapLoadGroupHierarchy (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadGroupHierarchy* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadGroupHierarchyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

