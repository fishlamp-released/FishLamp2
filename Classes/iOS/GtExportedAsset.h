//	This file was generated at 11/6/11 3:34 PM by PackMule. DO NOT MODIFY!!
//
//	GtExportedAsset.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtExportedAsset
// --------------------------------------------------------------------
@interface GtExportedAsset : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_originalID;
	NSString* m_assetURL;
	NSDate* m_exportedDate;
} 


@property (readwrite, retain, nonatomic) NSString* assetURL;

@property (readwrite, retain, nonatomic) NSDate* exportedDate;

@property (readwrite, retain, nonatomic) NSString* originalID;

+ (NSString*) assetURLKey;

+ (NSString*) exportedDateKey;

+ (NSString*) originalIDKey;

+ (GtExportedAsset*) exportedAsset; 

@end

@interface GtExportedAsset (ValueProperties) 
@end

