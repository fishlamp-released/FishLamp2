//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetPopularPhotos.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfGetPopularPhotos
// --------------------------------------------------------------------
@interface FLZfGetPopularPhotos : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (FLZfGetPopularPhotos*) getPopularPhotos; 

@end

@interface FLZfGetPopularPhotos (ValueProperties) 

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end

