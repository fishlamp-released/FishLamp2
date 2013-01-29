//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeletePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeletePhoto
// --------------------------------------------------------------------
@interface FLZfDeletePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) photoIdKey;

+ (FLZfDeletePhoto*) deletePhoto; 

@end

@interface FLZfDeletePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

