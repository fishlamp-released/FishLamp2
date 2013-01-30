//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioDeletePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) photoSetIdKey;

+ (FLZenfolioDeletePhotoSet*) deletePhotoSet; 

@end

@interface FLZenfolioDeletePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

