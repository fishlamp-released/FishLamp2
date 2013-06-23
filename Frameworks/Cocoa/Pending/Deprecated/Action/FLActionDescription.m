//
//	FLActionDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLActionDescription.h"

NSString* FLActionTypeUpload = nil;
NSString* FLActionTypeSave = nil;
NSString* FLActionTypeDownload = nil;
NSString* FLActionTypeWrite = nil;
NSString* FLActionTypeRead = nil;
NSString* FLActionTypeLoad = nil;
NSString* FLActionTypeSync = nil;
NSString* FLActionTypeUpdate= nil;

NSString* FLActionTypeDelete = nil;
NSString* FLActionTypeMove = nil;
NSString* FLActionTypeRename = nil;
NSString* FLActionTypeRefresh= nil;
NSString* FLActionTypeRemove = nil;
NSString* FLActionTypeAdd = nil;
NSString* FLActionTypeEmpty = nil;
NSString* FLActionTypeSort = nil;
NSString* FLActionTypeRotate = nil;
NSString* FLActionTypeAuthenticate = nil;
NSString* FLActionTypeTake = nil;
NSString* FLActionTypeCreate = nil;

NSString* FLActionTypeFeaturing = nil;
NSString* FLActionTypeUnFeaturing = nil;

NSString* FLActionTypeCopy = nil;
NSString* FLActionTypeOptimize = nil;

// --

NSString* FLActionDescriptionItemNamePhoto = nil;
NSString* FLActionDescriptionItemNameHighResolutionPhoto = nil;
NSString* FLActionDescriptionItemNameLargerPhoto = nil;
NSString* FLActionDescriptionItemNameThumbnail = nil;
NSString* FLActionDescriptionItemNameMetadata = nil;
NSString* FLActionDescriptionItemNameSettings= nil;
NSString* FLActionDescriptionItemNamePrefs= nil;
NSString* FLActionDescriptionItemNameUserProfile = nil;
NSString* FLActionDescriptionItemNameFolder= nil;
NSString* FLActionDescriptionItemNameFile= nil;
NSString* FLActionDescriptionItemNameCollection= nil;
NSString* FLActionDescriptionItemNameGallery= nil;
NSString* FLActionDescriptionItemNameGroup= nil;
NSString* FLActionDescriptionItemNameServer= nil;
NSString* FLActionDescriptionItemNameFeatured = nil;
NSString* FLActionDescriptionItemNameCache = nil;
NSString* FLActionDescriptionItemNameUploadQueue = nil;
NSString* FLActionDescriptionItemNamePhotoAlbum = nil;
NSString* FLActionDescriptionItemNameCategories = nil;
NSString* FLActionDescriptionItemNameCategory = nil;
NSString* FLActionDescriptionItemNameTitlePhoto = nil;
NSString* FLActionDescriptionItemNameTitleCamera = nil;

NSString* FLActionDescriptionItemNameNone = nil; 

@implementation FLActionDescription

@synthesize actionItemName = _itemName;
@synthesize actionType = _actionType;
@synthesize itemNameInProgress = _itemNameInProgress;
@synthesize customProgressString = _customProgressString;

+ (void) initialize
{
	FLActionTypeUpload = NSLocalizedString(@"Upload,Uploading,Uploaded", nil);
	FLActionTypeSave = NSLocalizedString(@"Save,Saving,Saved", nil);
	FLActionTypeDownload = NSLocalizedString(@"Download,Downloading,Downloaded", nil);
	FLActionTypeWrite = NSLocalizedString(@"Write,Writing,Written", nil);
	FLActionTypeRead = NSLocalizedString(@"Read,Reading,Read", nil);
	FLActionTypeLoad = NSLocalizedString(@"Load,Loading,Loaded", nil);
	FLActionTypeSync = NSLocalizedString(@"Sync,Syncing,Synced", nil);
	FLActionTypeUpdate= NSLocalizedString(@"Update,Updating,Updated", nil);

	FLActionTypeDelete = NSLocalizedString(@"Delete,Deleting,Deleted,Deletion", nil);
	FLActionTypeMove = NSLocalizedString(@"Move,Moving,Moved", nil);
	FLActionTypeRename = NSLocalizedString(@"Rename,Renaming,Renamed", nil);
	FLActionTypeRefresh= NSLocalizedString(@"Refresh,Refreshing,Refreshed", nil);
	FLActionTypeRemove = NSLocalizedString(@"Remove,Removing,Removed", nil);
	FLActionTypeAdd = NSLocalizedString(@"Add,Adding,Added", nil);
	FLActionTypeEmpty = NSLocalizedString(@"Empty,Emptying,Emptied", nil);
	FLActionTypeSort = NSLocalizedString(@"Sort,Sorting,Sorted", nil);
	FLActionTypeRotate = NSLocalizedString(@"Rotate,Rotating,Rotated,Rotation", nil);
	FLActionTypeAuthenticate = NSLocalizedString(@"Authenticate,Authenticating,Authenticated,Authentication", nil);
	FLActionTypeTake = NSLocalizedString(@"Take,Taking,Taken", nil);
	FLActionTypeCreate = NSLocalizedString(@"Create,Creating,Created,Creation", nil);

	FLActionTypeFeaturing = NSLocalizedString(@"Feature,Featuring,Featured", nil);
	FLActionTypeUnFeaturing = NSLocalizedString(@"Unfeature,Unfeaturing,Unfeatured", nil);

	FLActionTypeCopy = NSLocalizedString(@"Copy,Copying,Copied", nil);
	FLActionTypeOptimize = NSLocalizedString(@"Optimize,Optimizing,Optimized,Optimization", nil);

	// --

	FLActionDescriptionItemNamePhoto = NSLocalizedString(@"Photo", nil);
	FLActionDescriptionItemNameHighResolutionPhoto = NSLocalizedString(@"High Resolution Photo", nil);
	FLActionDescriptionItemNameLargerPhoto = NSLocalizedString(@"Larger Photo", nil);
	FLActionDescriptionItemNameThumbnail = NSLocalizedString(@"Thumbnail", nil);
	FLActionDescriptionItemNameMetadata = NSLocalizedString(@"Metadata", nil);
	FLActionDescriptionItemNameSettings= NSLocalizedString(@"Settings", nil);
	FLActionDescriptionItemNamePrefs= NSLocalizedString(@"Preferences", nil);
	FLActionDescriptionItemNameUserProfile = NSLocalizedString(@"User Profile", nil);
	FLActionDescriptionItemNameFolder= NSLocalizedString(@"Folder", nil);
	FLActionDescriptionItemNameFile= NSLocalizedString(@"File", nil);
	FLActionDescriptionItemNameCollection= NSLocalizedString(@"Collection", nil);
	FLActionDescriptionItemNameGallery= NSLocalizedString(@"Gallery", nil);
	FLActionDescriptionItemNameGroup= NSLocalizedString(@"Group", nil);
	FLActionDescriptionItemNameServer= NSLocalizedString(@"Server", nil);
	FLActionDescriptionItemNameFeatured = NSLocalizedString(@"Featured", nil);
	FLActionDescriptionItemNameCache = NSLocalizedString(@"Cache", nil);
	FLActionDescriptionItemNameUploadQueue = NSLocalizedString(@"Upload Queue", nil);
	FLActionDescriptionItemNamePhotoAlbum = NSLocalizedString(@"Photo Album", nil);
	FLActionDescriptionItemNameCategories = NSLocalizedString(@"Categories", nil);
	FLActionDescriptionItemNameCategory = NSLocalizedString(@"Category", nil);
	FLActionDescriptionItemNameTitlePhoto = NSLocalizedString(@"Photo", nil);
	FLActionDescriptionItemNameTitleCamera = NSLocalizedString(@"Camera", nil);
}

- (id) initWithActionType:(NSString*) actionType
	actionItemName:(NSString*) actionItemName
{
	if((self = [super init]))
	{
		self.actionType = actionType;
		self.actionItemName = actionItemName;
	}
	
	return self;
}

+ (FLActionDescription*) actionDescription
{
	return FLAutorelease([[FLActionDescription alloc] init]);
}

+ (FLActionDescription*) actionDescription:(NSString*) actionType
	actionItemName:(NSString*) actionItemName
{
	return FLAutorelease([[FLActionDescription alloc] initWithActionType:actionType actionItemName:actionItemName]);
}

- (void) dealloc
{
	FLRelease(_customProgressString);
	FLRelease(_actionType);
	FLRelease(_itemName);
	FLRelease(_actionWords);
	FLRelease(_itemNameInProgress);
	FLSuperDealloc();
}

- (NSString*) title
{
	if(_customProgressString)
	{
		return _customProgressString;
	}

	if(self.itemNameInProgress)
	{
		return [NSString stringWithFormat:@"%@ %@…", self.isWord, self.itemNameInProgress];
	}

	if(self.actionItemName)
	{
		return [NSString stringWithFormat:@"%@ %@…", self.isWord, self.actionItemName];
	}
	
	return [NSString stringWithFormat:@"%@…", self.isWord];
}


- (NSString*) failureText
{
	if(self.actionItemName)
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"%@ %@ Failed.", nil)), self.isWord, self.actionItemName];
	}
	else
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"%@ Failed.", nil)), self.nameWord];
	}
}

- (NSString*) unableText
{
	if(self.actionItemName)
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"Unable to %@ %@.", nil)), self.willWord, self.actionItemName];
	}
	else
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"Unable to %@.", nil)), self.willWord];
	}
}

- (NSArray*) allWords
{
	if(!_actionWords)
	{
		_actionWords = FLRetain([self.actionType componentsSeparatedByString:@","]);
	}
	return _actionWords;
}

- (NSString*) willWord
{
	return [self.allWords objectAtIndex:0]; 
}

- (NSString*) isWord
{
	return [self.allWords objectAtIndex:1]; 
}

- (NSString*) wasWord
{
	return [self.allWords objectAtIndex:2]; 
}

- (NSString*) nameWord
{
	return self.allWords.count == 4 ? [self.allWords objectAtIndex:3] : [self.allWords objectAtIndex:0];
}


@end
