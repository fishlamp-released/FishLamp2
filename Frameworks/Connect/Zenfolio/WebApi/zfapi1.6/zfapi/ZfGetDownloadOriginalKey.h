//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetDownloadOriginalKey.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface ZFGetDownloadOriginalKey : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _photoIds;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSNumber*, forKey: int

+ (NSString*) passwordKey;

+ (NSString*) photoIdsKey;

+ (ZFGetDownloadOriginalKey*) getDownloadOriginalKey; 

@end

@interface ZFGetDownloadOriginalKey (ValueProperties) 
@end

