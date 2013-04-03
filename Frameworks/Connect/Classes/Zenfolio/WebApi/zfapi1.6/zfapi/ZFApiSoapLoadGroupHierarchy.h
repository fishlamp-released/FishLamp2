//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadGroupHierarchy.h
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



@class ZFLoadGroupHierarchy;
@class ZFLoadGroupHierarchyResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadGroupHierarchy
// --------------------------------------------------------------------
@interface ZFApiSoapLoadGroupHierarchy : NSObject{ 
@private
	ZFLoadGroupHierarchy* _input;
	ZFLoadGroupHierarchyResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadGroupHierarchy* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadGroupHierarchyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadGroupHierarchy*) apiSoapLoadGroupHierarchy; 

@end

@interface ZFApiSoapLoadGroupHierarchy (ValueProperties) 
@end


@interface ZFApiSoapLoadGroupHierarchy (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadGroupHierarchy* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadGroupHierarchyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

