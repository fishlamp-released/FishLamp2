//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReindexPhotoSetHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFReindexPhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface ZFReindexPhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _startIndex;
	NSMutableArray* _mapping;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* mapping;
// Type: NSString*, forKey: String

@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* startIndex;

+ (NSString*) mappingKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) startIndexKey;

+ (ZFReindexPhotoSetHttpPostIn*) reindexPhotoSetHttpPostIn; 

@end

@interface ZFReindexPhotoSetHttpPostIn (ValueProperties) 
@end

