//
//	GtActionDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionDescription.h"

NSString* GtActionDescriptionTypeUpload = nil;
NSString* GtActionDescriptionTypeSave = nil;
NSString* GtActionDescriptionTypeDownload = nil;
NSString* GtActionDescriptionTypeWrite = nil;
NSString* GtActionDescriptionTypeRead = nil;
NSString* GtActionDescriptionTypeLoad = nil;
NSString* GtActionDescriptionTypeSync = nil;
NSString* GtActionDescriptionTypeUpdate= nil;

NSString* GtActionDescriptionTypeDelete = nil;
NSString* GtActionDescriptionTypeMove = nil;
NSString* GtActionDescriptionTypeRename = nil;
NSString* GtActionDescriptionTypeRefresh= nil;
NSString* GtActionDescriptionTypeRemove = nil;
NSString* GtActionDescriptionTypeAdd = nil;
NSString* GtActionDescriptionTypeEmpty = nil;
NSString* GtActionDescriptionTypeSort = nil;
NSString* GtActionDescriptionTypeRotate = nil;
NSString* GtActionDescriptionTypeAuthenticate = nil;
NSString* GtActionDescriptionTypeTake = nil;
NSString* GtActionDescriptionTypeCreate = nil;

NSString* GtActionDescriptionTypeFeaturing = nil;
NSString* GtActionDescriptionTypeUnFeaturing = nil;

NSString* GtActionDescriptionTypeCopy = nil;
NSString* GtActionDescriptionTypeOptimize = nil;

// --

NSString* GtActionDescriptionItemNamePhoto = nil;
NSString* GtActionDescriptionItemNameHighResolutionPhoto = nil;
NSString* GtActionDescriptionItemNameLargerPhoto = nil;
NSString* GtActionDescriptionItemNameThumbnail = nil;
NSString* GtActionDescriptionItemNameMetadata = nil;
NSString* GtActionDescriptionItemNameSettings= nil;
NSString* GtActionDescriptionItemNamePrefs= nil;
NSString* GtActionDescriptionItemNameUserProfile = nil;
NSString* GtActionDescriptionItemNameFolder= nil;
NSString* GtActionDescriptionItemNameFile= nil;
NSString* GtActionDescriptionItemNameCollection= nil;
NSString* GtActionDescriptionItemNameGallery= nil;
NSString* GtActionDescriptionItemNameGroup= nil;
NSString* GtActionDescriptionItemNameServer= nil;
NSString* GtActionDescriptionItemNameFeatured = nil;
NSString* GtActionDescriptionItemNameCache = nil;
NSString* GtActionDescriptionItemNameUploadQueue = nil;
NSString* GtActionDescriptionItemNamePhotoAlbum = nil;
NSString* GtActionDescriptionItemNameCategories = nil;
NSString* GtActionDescriptionItemNameCategory = nil;
NSString* GtActionDescriptionItemNameTitlePhoto = nil;
NSString* GtActionDescriptionItemNameTitleCamera = nil;

NSString* GtActionDescriptionItemNameNone = nil; 

@implementation GtActionDescription

@synthesize itemName = m_itemName;
@synthesize actionType = m_actionType;
@synthesize itemNameInProgress = m_itemNameInProgress;
@synthesize customProgressString = m_customProgressString;

+ (void) initialize
{
	GtActionDescriptionTypeUpload = NSLocalizedString(@"Upload,Uploading,Uploaded", nil);
	GtActionDescriptionTypeSave = NSLocalizedString(@"Save,Saving,Saved", nil);
	GtActionDescriptionTypeDownload = NSLocalizedString(@"Download,Downloading,Downloaded", nil);
	GtActionDescriptionTypeWrite = NSLocalizedString(@"Write,Writing,Written", nil);
	GtActionDescriptionTypeRead = NSLocalizedString(@"Read,Reading,Read", nil);
	GtActionDescriptionTypeLoad = NSLocalizedString(@"Load,Loading,Loaded", nil);
	GtActionDescriptionTypeSync = NSLocalizedString(@"Sync,Syncing,Synced", nil);
	GtActionDescriptionTypeUpdate= NSLocalizedString(@"Update,Updating,Updated", nil);

	GtActionDescriptionTypeDelete = NSLocalizedString(@"Delete,Deleting,Deleted,Deletion", nil);
	GtActionDescriptionTypeMove = NSLocalizedString(@"Move,Moving,Moved", nil);
	GtActionDescriptionTypeRename = NSLocalizedString(@"Rename,Renaming,Renamed", nil);
	GtActionDescriptionTypeRefresh= NSLocalizedString(@"Refresh,Refreshing,Refreshed", nil);
	GtActionDescriptionTypeRemove = NSLocalizedString(@"Remove,Removing,Removed", nil);
	GtActionDescriptionTypeAdd = NSLocalizedString(@"Add,Adding,Added", nil);
	GtActionDescriptionTypeEmpty = NSLocalizedString(@"Empty,Emptying,Emptied", nil);
	GtActionDescriptionTypeSort = NSLocalizedString(@"Sort,Sorting,Sorted", nil);
	GtActionDescriptionTypeRotate = NSLocalizedString(@"Rotate,Rotating,Rotated,Rotation", nil);
	GtActionDescriptionTypeAuthenticate = NSLocalizedString(@"Authenticate,Authenticating,Authenticated,Authentication", nil);
	GtActionDescriptionTypeTake = NSLocalizedString(@"Take,Taking,Taken", nil);
	GtActionDescriptionTypeCreate = NSLocalizedString(@"Create,Creating,Created,Creation", nil);

	GtActionDescriptionTypeFeaturing = NSLocalizedString(@"Feature,Featuring,Featured", nil);
	GtActionDescriptionTypeUnFeaturing = NSLocalizedString(@"Unfeature,Unfeaturing,Unfeatured", nil);

	GtActionDescriptionTypeCopy = NSLocalizedString(@"Copy,Copying,Copied", nil);
	GtActionDescriptionTypeOptimize = NSLocalizedString(@"Optimize,Optimizing,Optimized,Optimization", nil);

	// --

	GtActionDescriptionItemNamePhoto = NSLocalizedString(@"Photo", nil);
	GtActionDescriptionItemNameHighResolutionPhoto = NSLocalizedString(@"High Resolution Photo", nil);
	GtActionDescriptionItemNameLargerPhoto = NSLocalizedString(@"Larger Photo", nil);
	GtActionDescriptionItemNameThumbnail = NSLocalizedString(@"Thumbnail", nil);
	GtActionDescriptionItemNameMetadata = NSLocalizedString(@"Metadata", nil);
	GtActionDescriptionItemNameSettings= NSLocalizedString(@"Settings", nil);
	GtActionDescriptionItemNamePrefs= NSLocalizedString(@"Preferences", nil);
	GtActionDescriptionItemNameUserProfile = NSLocalizedString(@"User Profile", nil);
	GtActionDescriptionItemNameFolder= NSLocalizedString(@"Folder", nil);
	GtActionDescriptionItemNameFile= NSLocalizedString(@"File", nil);
	GtActionDescriptionItemNameCollection= NSLocalizedString(@"Collection", nil);
	GtActionDescriptionItemNameGallery= NSLocalizedString(@"Gallery", nil);
	GtActionDescriptionItemNameGroup= NSLocalizedString(@"Group", nil);
	GtActionDescriptionItemNameServer= NSLocalizedString(@"Server", nil);
	GtActionDescriptionItemNameFeatured = NSLocalizedString(@"Featured", nil);
	GtActionDescriptionItemNameCache = NSLocalizedString(@"Cache", nil);
	GtActionDescriptionItemNameUploadQueue = NSLocalizedString(@"Upload Queue", nil);
	GtActionDescriptionItemNamePhotoAlbum = NSLocalizedString(@"Photo Album", nil);
	GtActionDescriptionItemNameCategories = NSLocalizedString(@"Categories", nil);
	GtActionDescriptionItemNameCategory = NSLocalizedString(@"Category", nil);
	GtActionDescriptionItemNameTitlePhoto = NSLocalizedString(@"Photo", nil);
	GtActionDescriptionItemNameTitleCamera = NSLocalizedString(@"Camera", nil);
}

- (id) initWithActionType:(NSString*) actionType
	itemName:(NSString*) itemName
{
	if((self = [super init]))
	{
		self.actionType = actionType;
		self.itemName = itemName;
	}
	
	return self;
}

+ (GtActionDescription*) actionDescription
{
	return GtReturnAutoreleased([[GtActionDescription alloc] init]);
}

+ (GtActionDescription*) actionDescription:(NSString*) actionType
	itemName:(NSString*) itemName
{
	return GtReturnAutoreleased([[GtActionDescription alloc] initWithActionType:actionType itemName:itemName]);
}

- (void) dealloc
{
	GtRelease(m_customProgressString);
	GtRelease(m_actionType);
	GtRelease(m_itemName);
	GtRelease(m_actionWords);
	GtRelease(m_itemNameInProgress);
	GtSuperDealloc();
}

- (NSString*) title
{
	if(m_customProgressString)
	{
		return m_customProgressString;
	}

	if(self.itemNameInProgress)
	{
		return [NSString stringWithFormat:@"%@ %@…", self.isWord, self.itemNameInProgress];
	}

	if(self.itemName)
	{
		return [NSString stringWithFormat:@"%@ %@…", self.isWord, self.itemName];
	}
	
	return [NSString stringWithFormat:@"%@…", self.isWord];
}


- (NSString*) failureText
{
	if(self.itemName)
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"%@ %@ Failed.", nil)), self.isWord, self.itemName];
	}
	else
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"%@ Failed.", nil)), self.nameWord];
	}
}

- (NSString*) unableText
{
	if(self.itemName)
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"Unable to %@ %@.", nil)), self.willWord, self.itemName];
	}
	else
	{
		return [NSString stringWithFormat:(NSLocalizedString(@"Unable to %@.", nil)), self.willWord];
	}
}

- (NSArray*) allWords
{
	if(!m_actionWords)
	{
		m_actionWords = [[self.actionType componentsSeparatedByString:@","] retain];
	}
	return m_actionWords;
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
