//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioDeleteGroupHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioDeleteGroupHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioDeleteGroupHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

+ (NSString*) groupIdKey;

+ (FLZenfolioDeleteGroupHttpPostIn*) deleteGroupHttpPostIn; 

@end

@interface FLZenfolioDeleteGroupHttpPostIn (ValueProperties) 
@end
