//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReplacePhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFReplacePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFReplacePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _originalId;
	NSString* _replacedId;
} 


@property (readwrite, retain, nonatomic) NSString* originalId;

@property (readwrite, retain, nonatomic) NSString* replacedId;

+ (NSString*) originalIdKey;

+ (NSString*) replacedIdKey;

+ (ZFReplacePhotoHttpPostIn*) replacePhotoHttpPostIn; 

@end

@interface ZFReplacePhotoHttpPostIn (ValueProperties) 
@end

