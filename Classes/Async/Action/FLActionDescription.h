//
//	FLActionDescription.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

// TYPES

// strings are in form "will,is,was,name" (name is only required if different than will) 
// example: @"Upload,Uploading,Uploaded"
// example: @"Authenticate,Authenticating,Authenticated,Authentication"

extern NSString* FLActionDescriptionTypeUpload;
extern NSString* FLActionDescriptionTypeSave;
extern NSString* FLActionDescriptionTypeDownload;
extern NSString* FLActionDescriptionTypeWrite;
extern NSString* FLActionDescriptionTypeRead;
extern NSString* FLActionDescriptionTypeLoad;
extern NSString* FLActionDescriptionTypeSync;
extern NSString* FLActionDescriptionTypeUpdate;
extern NSString* FLActionDescriptionTypeDelete;
extern NSString* FLActionDescriptionTypeMove;
extern NSString* FLActionDescriptionTypeRename;
extern NSString* FLActionDescriptionTypeRefresh;
extern NSString* FLActionDescriptionTypeRemove;
extern NSString* FLActionDescriptionTypeAdd;
extern NSString* FLActionDescriptionTypeEmpty;
extern NSString* FLActionDescriptionTypeSort;
extern NSString* FLActionDescriptionTypeRotate;
extern NSString* FLActionDescriptionTypeAuthenticate;
extern NSString* FLActionDescriptionTypeTake;
extern NSString* FLActionDescriptionTypeCreate;
extern NSString* FLActionDescriptionTypeFeaturing;
extern NSString* FLActionDescriptionTypeUnFeaturing;
extern NSString* FLActionDescriptionTypeCopy;
extern NSString* FLActionDescriptionTypeOptimize;



// ITEM NAMES AND DESTINATIONS
extern NSString* FLActionDescriptionItemNamePhoto;
extern NSString* FLActionDescriptionItemNameLargerPhoto;
extern NSString* FLActionDescriptionItemNameHighResolutionPhoto;
extern NSString* FLActionDescriptionItemNameThumbnail;
extern NSString* FLActionDescriptionItemNameMetadata;
extern NSString* FLActionDescriptionItemNameSettings;
extern NSString* FLActionDescriptionItemNamePrefs;
extern NSString* FLActionDescriptionItemNameUserProfile;
extern NSString* FLActionDescriptionItemNameFolder;
extern NSString* FLActionDescriptionItemNameFile;
extern NSString* FLActionDescriptionItemNameCollection;
extern NSString* FLActionDescriptionItemNameGallery;
extern NSString* FLActionDescriptionItemNameGroup;
extern NSString* FLActionDescriptionItemNameServer;
extern NSString* FLActionDescriptionItemNameFeatured;
extern NSString* FLActionDescriptionItemNameCache;
extern NSString* FLActionDescriptionItemNameUploadQueue;
extern NSString* FLActionDescriptionItemNamePhotoAlbum;
extern NSString* FLActionDescriptionItemNameCategories;
extern NSString* FLActionDescriptionItemNameCategory;
extern NSString* FLActionDescriptionItemNameTitlePhoto;
extern NSString* FLActionDescriptionItemNameTitleCamera;

extern NSString* FLActionDescriptionItemNameNone;

@protocol FLActionDescription 
@property (readwrite, retain, nonatomic) NSString* actionType;
@property (readwrite, retain, nonatomic) NSString* actionItemName;
@property (readwrite, retain, nonatomic) NSString* itemNameInProgress;
@end

@interface FLActionDescription : NSObject<FLActionDescription> {
@private
	NSString* _actionType;
	NSString* _itemName;
	NSString* _itemNameInProgress;
	NSArray* _actionWords;
	NSString* _customProgressString;	
}

@property (readwrite, retain, nonatomic) NSString* customProgressString; // overrides everthing else

@property (readwrite, retain, nonatomic) NSString* actionType;
@property (readwrite, retain, nonatomic) NSString* actionItemName;
@property (readwrite, retain, nonatomic) NSString* itemNameInProgress;

@property (readonly, retain, nonatomic) NSArray* allWords;

@property (readonly, assign, nonatomic) NSString* willWord;
@property (readonly, assign, nonatomic) NSString* isWord;
@property (readonly, assign, nonatomic) NSString* wasWord;
@property (readonly, assign, nonatomic) NSString* nameWord;

- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

+ (FLActionDescription*) actionDescription;
+ (FLActionDescription*) actionDescription:(NSString*) actionType
	actionItemName:(NSString*) actionItemName;

- (NSString*) title;
- (NSString*) failureText;
- (NSString*) unableText;
@end
