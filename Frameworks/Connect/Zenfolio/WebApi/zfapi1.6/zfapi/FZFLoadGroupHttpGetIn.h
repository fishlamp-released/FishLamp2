//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadGroupHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadGroupHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioLoadGroupHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _level;
	NSString* _includeChildren;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* includeChildren;

@property (readwrite, retain, nonatomic) NSString* level;

+ (NSString*) groupIdKey;

+ (NSString*) includeChildrenKey;

+ (NSString*) levelKey;

+ (FLZenfolioLoadGroupHttpGetIn*) loadGroupHttpGetIn; 

@end

@interface FLZenfolioLoadGroupHttpGetIn (ValueProperties) 
@end

