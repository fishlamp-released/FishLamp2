//	This file was generated at 11/26/11 5:25 PM by PackMule. DO NOT MODIFY!!
//
//	GtApplicationDataVersion.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtApplicationDataVersion
// --------------------------------------------------------------------
@interface GtApplicationDataVersion : NSObject{ 
@private
	NSString* m_userGuid;
	NSString* m_versionString;
} 


@property (readwrite, retain, nonatomic) NSString* userGuid;

@property (readwrite, retain, nonatomic) NSString* versionString;

+ (NSString*) userGuidKey;

+ (NSString*) versionStringKey;

+ (GtApplicationDataVersion*) applicationDataVersion; 

@end

@interface GtApplicationDataVersion (ValueProperties) 
@end

