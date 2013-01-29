//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdateGroupAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfUpdateGroupAccessResponse
// --------------------------------------------------------------------
@interface FLZfUpdateGroupAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdateGroupAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdateGroupAccessResult;

+ (NSString*) UpdateGroupAccessResultKey;

+ (FLZfUpdateGroupAccessResponse*) updateGroupAccessResponse; 

@end

@interface FLZfUpdateGroupAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdateGroupAccessResultValue;
@end

