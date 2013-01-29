//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfResolveReference.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfResolveReference
// --------------------------------------------------------------------
@interface FLZfResolveReference : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _reference;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* reference;

+ (NSString*) loginNameKey;

+ (NSString*) referenceKey;

+ (FLZfResolveReference*) resolveReference; 

@end

@interface FLZfResolveReference (ValueProperties) 
@end

