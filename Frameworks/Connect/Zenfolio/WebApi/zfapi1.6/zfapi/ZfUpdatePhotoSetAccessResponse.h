//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSetAccessResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFUpdatePhotoSetAccessResponse
// --------------------------------------------------------------------
@interface ZFUpdatePhotoSetAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoSetAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoSetAccessResult;

+ (NSString*) UpdatePhotoSetAccessResultKey;

+ (ZFUpdatePhotoSetAccessResponse*) updatePhotoSetAccessResponse; 

@end

@interface ZFUpdatePhotoSetAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoSetAccessResultValue;
@end

