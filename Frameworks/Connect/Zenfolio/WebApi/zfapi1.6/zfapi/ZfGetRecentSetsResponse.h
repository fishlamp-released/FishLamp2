//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetRecentSetsResponse.h
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
// ZFGetRecentSetsResponse
// --------------------------------------------------------------------
@interface ZFGetRecentSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentSetsResult;
// Type: ZFPhotoSet*, forKey: PhotoSet

+ (NSString*) GetRecentSetsResultKey;

+ (ZFGetRecentSetsResponse*) getRecentSetsResponse; 

@end

@interface ZFGetRecentSetsResponse (ValueProperties) 
@end

