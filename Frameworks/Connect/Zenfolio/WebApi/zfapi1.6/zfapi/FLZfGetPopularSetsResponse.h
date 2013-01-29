//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetPopularSetsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfGetPopularSetsResponse
// --------------------------------------------------------------------
@interface FLZfGetPopularSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetPopularSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetPopularSetsResult;
// Type: FLZfPhotoSet*, forKey: PhotoSet

+ (NSString*) GetPopularSetsResultKey;

+ (FLZfGetPopularSetsResponse*) getPopularSetsResponse; 

@end

@interface FLZfGetPopularSetsResponse (ValueProperties) 
@end

