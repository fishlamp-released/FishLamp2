//	This file was generated at 7/3/11 2:20 PM by PackMule. DO NOT MODIFY!!
//
//	GtDatabaseObject.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtDatabaseObject
// --------------------------------------------------------------------
@interface GtDatabaseObject : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_uid;
} 


@property (readwrite, retain, nonatomic) NSString* uid;

+ (NSString*) uidKey;

+ (GtDatabaseObject*) databaseObject; 

@end

@interface GtDatabaseObject (ValueProperties) 
@end

