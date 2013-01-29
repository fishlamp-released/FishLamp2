//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAccessUpdater.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFAccessUpdater
// --------------------------------------------------------------------
@interface ZFAccessUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AccessMask;
	NSString* _Password;
	NSString* _AccessType;
	NSMutableArray* _Viewers;
	NSNumber* _IsDerived;
} 


@property (readwrite, retain, nonatomic) NSString* AccessMask;

@property (readwrite, retain, nonatomic) NSString* AccessType;

@property (readwrite, retain, nonatomic) NSNumber* IsDerived;

@property (readwrite, retain, nonatomic) NSString* Password;

@property (readwrite, retain, nonatomic) NSMutableArray* Viewers;
// Type: NSString*, forKey: Viewer

+ (NSString*) AccessMaskKey;

+ (NSString*) AccessTypeKey;

+ (NSString*) IsDerivedKey;

+ (NSString*) PasswordKey;

+ (NSString*) ViewersKey;

+ (ZFAccessUpdater*) accessUpdater; 

@end

@interface ZFAccessUpdater (ValueProperties) 

@property (readwrite, assign, nonatomic) ZFApiAccessMask AccessMaskValue;

@property (readwrite, assign, nonatomic) ZFAccessType AccessTypeValue;

@property (readwrite, assign, nonatomic) BOOL IsDerivedValue;
@end

