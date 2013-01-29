//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoFromUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCreatePhotoFromUrlResponse
// --------------------------------------------------------------------
@interface FLZfCreatePhotoFromUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreatePhotoFromUrlResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreatePhotoFromUrlResult;

+ (NSString*) CreatePhotoFromUrlResultKey;

+ (FLZfCreatePhotoFromUrlResponse*) createPhotoFromUrlResponse; 

@end

@interface FLZfCreatePhotoFromUrlResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreatePhotoFromUrlResultValue;
@end

