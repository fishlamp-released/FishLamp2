//
//	GtActionDescription.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

// TYPES

// strings are in form "will,is,was,name" (name is only required if different than will) 
// example: @"Upload,Uploading,Uploaded"
// example: @"Authenticate,Authenticating,Authenticated,Authentication"

extern NSString* GtActionDescriptionTypeUpload;
extern NSString* GtActionDescriptionTypeSave;
extern NSString* GtActionDescriptionTypeDownload;
extern NSString* GtActionDescriptionTypeWrite;
extern NSString* GtActionDescriptionTypeRead;
extern NSString* GtActionDescriptionTypeLoad;
extern NSString* GtActionDescriptionTypeSync;
extern NSString* GtActionDescriptionTypeUpdate;
extern NSString* GtActionDescriptionTypeDelete;
extern NSString* GtActionDescriptionTypeMove;
extern NSString* GtActionDescriptionTypeRename;
extern NSString* GtActionDescriptionTypeRefresh;
extern NSString* GtActionDescriptionTypeRemove;
extern NSString* GtActionDescriptionTypeAdd;
extern NSString* GtActionDescriptionTypeEmpty;
extern NSString* GtActionDescriptionTypeSort;
extern NSString* GtActionDescriptionTypeRotate;
extern NSString* GtActionDescriptionTypeAuthenticate;
extern NSString* GtActionDescriptionTypeTake;
extern NSString* GtActionDescriptionTypeCreate;
extern NSString* GtActionDescriptionTypeFeaturing;
extern NSString* GtActionDescriptionTypeUnFeaturing;
extern NSString* GtActionDescriptionTypeCopy;
extern NSString* GtActionDescriptionTypeOptimize;



// ITEM NAMES AND DESTINATIONS
extern NSString* GtActionDescriptionItemNamePhoto;
extern NSString* GtActionDescriptionItemNameLargerPhoto;
extern NSString* GtActionDescriptionItemNameHighResolutionPhoto;
extern NSString* GtActionDescriptionItemNameThumbnail;
extern NSString* GtActionDescriptionItemNameMetadata;
extern NSString* GtActionDescriptionItemNameSettings;
extern NSString* GtActionDescriptionItemNamePrefs;
extern NSString* GtActionDescriptionItemNameUserProfile;
extern NSString* GtActionDescriptionItemNameFolder;
extern NSString* GtActionDescriptionItemNameFile;
extern NSString* GtActionDescriptionItemNameCollection;
extern NSString* GtActionDescriptionItemNameGallery;
extern NSString* GtActionDescriptionItemNameGroup;
extern NSString* GtActionDescriptionItemNameServer;
extern NSString* GtActionDescriptionItemNameFeatured;
extern NSString* GtActionDescriptionItemNameCache;
extern NSString* GtActionDescriptionItemNameUploadQueue;
extern NSString* GtActionDescriptionItemNamePhotoAlbum;
extern NSString* GtActionDescriptionItemNameCategories;
extern NSString* GtActionDescriptionItemNameCategory;
extern NSString* GtActionDescriptionItemNameTitlePhoto;
extern NSString* GtActionDescriptionItemNameTitleCamera;

extern NSString* GtActionDescriptionItemNameNone;

@interface GtActionDescription : NSObject {
@private
	NSString* m_actionType;
	NSString* m_itemName;
	NSString* m_itemNameInProgress;
	NSArray* m_actionWords;
	NSString* m_customProgressString;	
}

@property (readwrite, retain, nonatomic) NSString* customProgressString; // overrides everthing else

@property (readwrite, retain, nonatomic) NSString* actionType;
@property (readwrite, retain, nonatomic) NSString* itemName;
@property (readwrite, retain, nonatomic) NSString* itemNameInProgress;

@property (readonly, retain, nonatomic) NSArray* allWords;

@property (readonly, assign, nonatomic) NSString* willWord;
@property (readonly, assign, nonatomic) NSString* isWord;
@property (readonly, assign, nonatomic) NSString* wasWord;
@property (readonly, assign, nonatomic) NSString* nameWord;

- (id) initWithActionType:(NSString*) actionType itemName:(NSString*) itemName;

+ (GtActionDescription*) actionDescription;
+ (GtActionDescription*) actionDescription:(NSString*) actionType
	itemName:(NSString*) itemName;

- (NSString*) title;
- (NSString*) failureText;
- (NSString*) unableText;
@end
