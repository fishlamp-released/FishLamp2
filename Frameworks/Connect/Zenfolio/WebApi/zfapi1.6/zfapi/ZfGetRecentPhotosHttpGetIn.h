//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetRecentPhotosHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGetRecentPhotosHttpGetIn
// --------------------------------------------------------------------
@interface ZFGetRecentPhotosHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _offset;
	NSString* _limit;
} 


@property (readwrite, retain, nonatomic) NSString* limit;

@property (readwrite, retain, nonatomic) NSString* offset;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (ZFGetRecentPhotosHttpGetIn*) getRecentPhotosHttpGetIn; 

@end

@interface ZFGetRecentPhotosHttpGetIn (ValueProperties) 
@end

