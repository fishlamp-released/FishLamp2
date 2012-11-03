//
//	FLActionDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLActionDescription.h"

NSString* FLActionDescriptionTypeUpload = nil;
NSString* FLActionDescriptionTypeSave = nil;
NSString* FLActionDescriptionTypeDownload = nil;
NSString* FLActionDescriptionTypeWrite = nil;
NSString* FLActionDescriptionTypeRead = nil;
NSString* FLActionDescriptionTypeLoad = nil;
NSString* FLActionDescriptionTypeSync = nil;
NSString* FLActionDescriptionTypeUpdate= nil;

NSString* FLActionDescriptionTypeDelete = nil;
NSString* FLActionDescriptionTypeMove = nil;
NSString* FLActionDescriptionTypeRename = nil;
NSString* FLActionDescriptionTypeRefresh= nil;
NSString* FLActionDescriptionTypeRemove = nil;
NSString* FLActionDescriptionTypeAdd = nil;
NSString* FLActionDescriptionTypeEmpty = nil;
NSString* FLActionDescriptionTypeSort = nil;
NSString* FLActionDescriptionTypeRotate = nil;
NSString* FLActionDescriptionTypeAuthenticate = nil;
NSString* FLActionDescriptionTypeTake = nil;
NSString* FLActionDescriptionTypeCreate = nil;

NSString* FLActionDescriptionTypeFeaturing = nil;
NSString* FLActionDescriptionTypeUnFeaturing = nil;

NSString* FLActionDescriptionTypeCopy = nil;
NSString* FLActionDescriptionTypeOptimize = nil;

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
	FLActionDescriptionTypeUpload = NSLocalizedString(@"Upload,Uploading,Uploaded", nil);
	FLActionDescriptionTypeSave = NSLocalizedString(@"Save,Saving,Saved", nil);
	FLActionDescriptionTypeDownload = NSLocalizedString(@"Download,Downloading,Downloaded", nil);
	FLActionDescriptionTypeWrite = NSLocalizedString(@"Write,Writing,Written", nil);
	FLActionDescriptionTypeRead = NSLocalizedString(@"Read,Reading,Read", nil);
	FLActionDescriptionTypeLoad = NSLocalizedString(@"Load,Loading,Loaded", nil);
	FLActionDescriptionTypeSync = NSLocalizedString(@"Sync,Syncing,Synced", nil);
	FLActionDescriptionTypeUpdate= NSLocalizedString(@"Update,Updating,Updated", nil);

	FLActionDescriptionTypeDelete = NSLocalizedString(@"Delete,Deleting,Deleted,Deletion", nil);
	FLActionDescriptionTypeMove = NSLocalizedString(@"Move,Moving,Moved", nil);
	FLActionDescriptionTypeRename = NSLocalizedString(@"Rename,Renaming,Renamed", nil);
	FLActionDescriptionTypeRefresh= NSLocalizedString(@"Refresh,Refreshing,Refreshed", nil);
	FLActionDescriptionTypeRemove = NSLocalizedString(@"Remove,Removing,Removed", nil);
	FLActionDescriptionTypeAdd = NSLocalizedString(@"Add,Adding,Added", nil);
	FLActionDescriptionTypeEmpty = NSLocalizedString(@"Empty,Emptying,Emptied", nil);
	FLActionDescriptionTypeSort = NSLocalizedString(@"Sort,Sorting,Sorted", nil);
	FLActionDescriptionTypeRotate = NSLocalizedString(@"Rotate,Rotating,Rotated,Rotation", nil);
	FLActionDescriptionTypeAuthenticate = NSLocalizedString(@"Authenticate,Authenticating,Authenticated,Authentication", nil);
	FLActionDescriptionTypeTake = NSLocalizedString(@"Take,Taking,Taken", nil);
	FLActionDescriptionTypeCreate = NSLocalizedString(@"Create,Creating,Created,Creation", nil);

	FLActionDescriptionTypeFeaturing = NSLocalizedString(@"Feature,Featuring,Featured", nil);
	FLActionDescriptionTypeUnFeaturing = NSLocalizedString(@"Unfeature,Unfeaturing,Unfeatured", nil);

	FLActionDescriptionTypeCopy = NSLocalizedString(@"Copy,Copying,Copied", nil);
	FLActionDescriptionTypeOptimize = NSLocalizedString(@"Optimize,Optimizing,Optimized,Optimization", nil);

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
	return autorelease_([[FLActionDescription alloc] init]);
}

+ (FLActionDescription*) actionDescription:(NSString*) actionType
	actionItemName:(NSString*) actionItemName
{
	return autorelease_([[FLActionDescription alloc] initWithActionType:actionType actionItemName:actionItemName]);
}

- (void) dealloc
{
	mrc_release_(_customProgressString);
	mrc_release_(_actionType);
	mrc_release_(_itemName);
	mrc_release_(_actionWords);
	mrc_release_(_itemNameInProgress);
	super_dealloc_();
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
		_actionWords = retain_([self.actionType componentsSeparatedByString:@","]);
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
