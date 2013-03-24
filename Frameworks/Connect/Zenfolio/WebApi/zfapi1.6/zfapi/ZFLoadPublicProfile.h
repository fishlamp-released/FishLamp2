//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPublicProfile.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadPublicProfile
// --------------------------------------------------------------------
@interface ZFLoadPublicProfile : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

+ (NSString*) loginNameKey;

+ (ZFLoadPublicProfile*) loadPublicProfile; 

@end

@interface ZFLoadPublicProfile (ValueProperties) 
@end

