//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPublicProfileHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPublicProfileHttpPostIn
// --------------------------------------------------------------------
@interface FLZfLoadPublicProfileHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

+ (NSString*) loginNameKey;

+ (FLZfLoadPublicProfileHttpPostIn*) loadPublicProfileHttpPostIn; 

@end

@interface FLZfLoadPublicProfileHttpPostIn (ValueProperties) 
@end

