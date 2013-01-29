//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetRecentSetsResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfGetRecentSetsResponse
// --------------------------------------------------------------------
@interface FLZfGetRecentSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentSetsResult;
// Type: FLZfPhotoSet*, forKey: PhotoSet

+ (NSString*) GetRecentSetsResultKey;

+ (FLZfGetRecentSetsResponse*) getRecentSetsResponse; 

@end

@interface FLZfGetRecentSetsResponse (ValueProperties) 
@end

