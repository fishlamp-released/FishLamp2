//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadGroupHierarchy.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads group hierarchy of the specified user. <A href="/zf/help/api/ref/methods/loadgrouphierarchy">More...</A>
*/



@class ZFLoadGroupHierarchyHttpGetIn;
@class ZFGroup;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadGroupHierarchy
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadGroupHierarchy : NSObject{ 
@private
	ZFLoadGroupHierarchyHttpGetIn* _input;
	ZFGroup* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadGroupHierarchyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadGroupHierarchy*) apiHttpGetLoadGroupHierarchy; 

@end

@interface ZFApiHttpGetLoadGroupHierarchy (ValueProperties) 
@end


@interface ZFApiHttpGetLoadGroupHierarchy (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadGroupHierarchyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

