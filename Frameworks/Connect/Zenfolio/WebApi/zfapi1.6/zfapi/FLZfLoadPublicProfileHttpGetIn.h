//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPublicProfileHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPublicProfileHttpGetIn
// --------------------------------------------------------------------
@interface FLZfLoadPublicProfileHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

+ (NSString*) loginNameKey;

+ (FLZfLoadPublicProfileHttpGetIn*) loadPublicProfileHttpGetIn; 

@end

@interface FLZfLoadPublicProfileHttpGetIn (ValueProperties) 
@end

