//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetPhotoSetTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface ZFSetPhotoSetTitlePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) photoIdKey;

+ (NSString*) photoSetIdKey;

+ (ZFSetPhotoSetTitlePhoto*) setPhotoSetTitlePhoto; 

@end

@interface ZFSetPhotoSetTitlePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

