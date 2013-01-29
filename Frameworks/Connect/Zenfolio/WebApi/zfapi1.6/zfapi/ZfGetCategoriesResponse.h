//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetCategoriesResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFCategory;

// --------------------------------------------------------------------
// ZFGetCategoriesResponse
// --------------------------------------------------------------------
@interface ZFGetCategoriesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetCategoriesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetCategoriesResult;
// Type: ZFCategory*, forKey: Category

+ (NSString*) GetCategoriesResultKey;

+ (ZFGetCategoriesResponse*) getCategoriesResponse; 

@end

@interface ZFGetCategoriesResponse (ValueProperties) 
@end

