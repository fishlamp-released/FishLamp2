//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetCategoriesResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioCategory;

// --------------------------------------------------------------------
// FLZenfolioGetCategoriesResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetCategoriesResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetCategoriesResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetCategoriesResult;
// Type: FLZenfolioCategory*, forKey: Category

+ (NSString*) GetCategoriesResultKey;

+ (FLZenfolioGetCategoriesResponse*) getCategoriesResponse; 

@end

@interface FLZenfolioGetCategoriesResponse (ValueProperties) 
@end

