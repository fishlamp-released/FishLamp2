//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupHierarchyHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadGroupHierarchyHttpPostIn
// --------------------------------------------------------------------
@interface ZFLoadGroupHierarchyHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

+ (NSString*) loginNameKey;

+ (ZFLoadGroupHierarchyHttpPostIn*) loadGroupHierarchyHttpPostIn; 

@end

@interface ZFLoadGroupHierarchyHttpPostIn (ValueProperties) 
@end

