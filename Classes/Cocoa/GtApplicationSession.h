//	This file was generated at 7/3/11 10:43 AM by PackMule. DO NOT MODIFY!!
//
//	GtApplicationSession.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtApplicationSession
// --------------------------------------------------------------------
@interface GtApplicationSession : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_sessionId;
	NSString* m_userGuid;
} 


@property (readwrite, retain, nonatomic) NSNumber* sessionId;

@property (readwrite, retain, nonatomic) NSString* userGuid;

+ (NSString*) sessionIdKey;

+ (NSString*) userGuidKey;

+ (GtApplicationSession*) applicationSession; 

@end

@interface GtApplicationSession (ValueProperties) 

@property (readwrite, assign, nonatomic) int sessionIdValue;
@end

