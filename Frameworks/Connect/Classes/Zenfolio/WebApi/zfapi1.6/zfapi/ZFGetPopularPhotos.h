//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetPopularPhotos.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGetPopularPhotos
// --------------------------------------------------------------------
@interface ZFGetPopularPhotos : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (ZFGetPopularPhotos*) getPopularPhotos; 

@end

@interface ZFGetPopularPhotos (ValueProperties) 

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end

