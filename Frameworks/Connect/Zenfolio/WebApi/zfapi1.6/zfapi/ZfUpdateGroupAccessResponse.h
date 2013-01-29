//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroupAccessResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFUpdateGroupAccessResponse
// --------------------------------------------------------------------
@interface ZFUpdateGroupAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdateGroupAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdateGroupAccessResult;

+ (NSString*) UpdateGroupAccessResultKey;

+ (ZFUpdateGroupAccessResponse*) updateGroupAccessResponse; 

@end

@interface ZFUpdateGroupAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdateGroupAccessResultValue;
@end

