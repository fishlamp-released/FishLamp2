//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdateGroupAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioUpdateGroupAccessResponse
// --------------------------------------------------------------------
@interface FLZenfolioUpdateGroupAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdateGroupAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdateGroupAccessResult;

+ (NSString*) UpdateGroupAccessResultKey;

+ (FLZenfolioUpdateGroupAccessResponse*) updateGroupAccessResponse; 

@end

@interface FLZenfolioUpdateGroupAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdateGroupAccessResultValue;
@end

