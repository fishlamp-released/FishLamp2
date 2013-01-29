//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSetGroupTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface FLZfSetGroupTitlePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) groupIdKey;

+ (NSString*) photoIdKey;

+ (FLZfSetGroupTitlePhoto*) setGroupTitlePhoto; 

@end

@interface FLZfSetGroupTitlePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

