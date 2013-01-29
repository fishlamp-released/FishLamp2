//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetCategoriesResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfCategory;

// --------------------------------------------------------------------
// FLZfGetCategoriesResponse
// --------------------------------------------------------------------
@interface FLZfGetCategoriesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetCategoriesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetCategoriesResult;
// Type: FLZfCategory*, forKey: Category

+ (NSString*) GetCategoriesResultKey;

+ (FLZfGetCategoriesResponse*) getCategoriesResponse; 

@end

@interface FLZfGetCategoriesResponse (ValueProperties) 
@end

