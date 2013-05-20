//	This file was generated at 7/3/11 10:38 AM by PackMule. DO NOT MODIFY!!
//
//	GtLastUpdateTime.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtLastUpdateTime
// --------------------------------------------------------------------
@interface GtLastUpdateTime : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_lastUpdateId;
	NSDate* m_lastUpdate;
} 


@property (readwrite, retain, nonatomic) NSDate* lastUpdate;

@property (readwrite, retain, nonatomic) NSString* lastUpdateId;

+ (NSString*) lastUpdateIdKey;

+ (NSString*) lastUpdateKey;

+ (GtLastUpdateTime*) lastUpdateTime; 

@end

@interface GtLastUpdateTime (ValueProperties) 
@end

