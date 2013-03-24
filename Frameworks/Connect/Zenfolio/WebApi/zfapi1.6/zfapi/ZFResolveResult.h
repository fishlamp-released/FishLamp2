//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFResolveResult.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFGroup;
@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFResolveResult
// --------------------------------------------------------------------
@interface ZFResolveResult : NSObject<NSCoding, NSCopying>{ 
@private
	ZFGroup* _Group;
	ZFPhotoSet* _PhotoSet;
} 


@property (readwrite, retain, nonatomic) ZFGroup* Group;

@property (readwrite, retain, nonatomic) ZFPhotoSet* PhotoSet;

+ (NSString*) GroupKey;

+ (NSString*) PhotoSetKey;

+ (ZFResolveResult*) resolveResult; 

@end

@interface ZFResolveResult (ValueProperties) 
@end

