//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfResolveResult.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfGroup;
@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfResolveResult
// --------------------------------------------------------------------
@interface FLZfResolveResult : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfGroup* _Group;
	FLZfPhotoSet* _PhotoSet;
} 


@property (readwrite, retain, nonatomic) FLZfGroup* Group;

@property (readwrite, retain, nonatomic) FLZfPhotoSet* PhotoSet;

+ (NSString*) GroupKey;

+ (NSString*) PhotoSetKey;

+ (FLZfResolveResult*) resolveResult; 

@end

@interface FLZfResolveResult (ValueProperties) 
@end

