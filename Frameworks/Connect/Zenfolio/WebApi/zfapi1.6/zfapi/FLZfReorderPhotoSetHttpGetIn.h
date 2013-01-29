//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfReorderPhotoSetHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfReorderPhotoSetHttpGetIn
// --------------------------------------------------------------------
@interface FLZfReorderPhotoSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) photoSetIdKey;

+ (NSString*) shiftOrderKey;

+ (FLZfReorderPhotoSetHttpGetIn*) reorderPhotoSetHttpGetIn; 

@end

@interface FLZfReorderPhotoSetHttpGetIn (ValueProperties) 
@end

