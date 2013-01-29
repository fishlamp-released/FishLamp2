//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoAccessResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfUpdatePhotoAccessResponse
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoAccessResult;

+ (NSString*) UpdatePhotoAccessResultKey;

+ (FLZfUpdatePhotoAccessResponse*) updatePhotoAccessResponse; 

@end

@interface FLZfUpdatePhotoAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoAccessResultValue;
@end

