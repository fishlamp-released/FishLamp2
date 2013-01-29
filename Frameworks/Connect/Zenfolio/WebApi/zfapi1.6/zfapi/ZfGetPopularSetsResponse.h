//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetPopularSetsResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFGetPopularSetsResponse
// --------------------------------------------------------------------
@interface ZFGetPopularSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetPopularSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetPopularSetsResult;
// Type: ZFPhotoSet*, forKey: PhotoSet

+ (NSString*) GetPopularSetsResultKey;

+ (ZFGetPopularSetsResponse*) getPopularSetsResponse; 

@end

@interface ZFGetPopularSetsResponse (ValueProperties) 
@end

