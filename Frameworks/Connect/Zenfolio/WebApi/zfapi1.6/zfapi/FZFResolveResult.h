//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioResolveResult.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioGroup;
@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioResolveResult
// --------------------------------------------------------------------
@interface FLZenfolioResolveResult : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioGroup* _Group;
	FLZenfolioPhotoSet* _PhotoSet;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGroup* Group;

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* PhotoSet;

+ (NSString*) GroupKey;

+ (NSString*) PhotoSetKey;

+ (FLZenfolioResolveResult*) resolveResult; 

@end

@interface FLZenfolioResolveResult (ValueProperties) 
@end

