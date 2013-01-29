//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoSetAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfUpdatePhotoSetAccessResponse
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoSetAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoSetAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoSetAccessResult;

+ (NSString*) UpdatePhotoSetAccessResultKey;

+ (FLZfUpdatePhotoSetAccessResponse*) updatePhotoSetAccessResponse; 

@end

@interface FLZfUpdatePhotoSetAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoSetAccessResultValue;
@end

