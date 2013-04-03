//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostLoadGroupHierarchy.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads group hierarchy of the specified user. <A href="/Zenfolio/help/api/ref/methods/loadgrouphierarchy">More...</A>
*/



@class ZFLoadGroupHierarchyHttpPostIn;
@class ZFGroup;

// --------------------------------------------------------------------
// ZFApiHttpPostLoadGroupHierarchy
// --------------------------------------------------------------------
@interface ZFApiHttpPostLoadGroupHierarchy : NSObject{ 
@private
	ZFLoadGroupHierarchyHttpPostIn* _input;
	ZFGroup* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadGroupHierarchyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostLoadGroupHierarchy*) apiHttpPostLoadGroupHierarchy; 

@end

@interface ZFApiHttpPostLoadGroupHierarchy (ValueProperties) 
@end


@interface ZFApiHttpPostLoadGroupHierarchy (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadGroupHierarchyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

