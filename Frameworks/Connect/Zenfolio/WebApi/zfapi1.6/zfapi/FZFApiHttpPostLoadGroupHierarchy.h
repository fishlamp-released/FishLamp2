//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadGroupHierarchy.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads group hierarchy of the specified user. <A href="/Zenfolio/help/api/ref/methods/loadgrouphierarchy">More...</A>
*/



@class FLZenfolioLoadGroupHierarchyHttpPostIn;
@class FLZenfolioGroup;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadGroupHierarchy
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadGroupHierarchy : NSObject{ 
@private
	FLZenfolioLoadGroupHierarchyHttpPostIn* _input;
	FLZenfolioGroup* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadGroupHierarchyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadGroupHierarchy*) apiHttpPostLoadGroupHierarchy; 

@end

@interface FLZenfolioApiHttpPostLoadGroupHierarchy (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadGroupHierarchy (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadGroupHierarchyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

