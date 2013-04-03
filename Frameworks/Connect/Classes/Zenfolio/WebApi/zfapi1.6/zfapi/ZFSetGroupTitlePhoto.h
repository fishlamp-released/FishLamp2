//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetGroupTitlePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface ZFSetGroupTitlePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) groupIdKey;

+ (NSString*) photoIdKey;

+ (ZFSetGroupTitlePhoto*) setGroupTitlePhoto; 

@end

@interface ZFSetGroupTitlePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

