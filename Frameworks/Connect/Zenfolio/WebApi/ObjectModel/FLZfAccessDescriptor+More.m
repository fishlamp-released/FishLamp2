//
//  FLZfAccessDescriptor+More.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfAccessDescriptor+More.h"
#import "NSString+Lists.h"

@implementation FLZfAccessDescriptor (More)

- (NSString*) derivedString
{
	return NSLocalizedString(@"Same as Container", nil);
}

+ (NSString*) accessTypeString:(FLZfAccessType) accessType
{
	switch(accessType)
	{
		case FLZfAccessTypePrivate:
			return NSLocalizedString(@"Private", nil);
		break;
		case FLZfAccessTypeUserList:
			return NSLocalizedString(@"Allowed Zenfolio users only", nil);
		break;
		case FLZfAccessTypePassword:
			return NSLocalizedString(@"Locked with password", nil);
		break;
		case FLZfAccessTypePublic:
			return NSLocalizedString(@"Public", nil);
		break;
	}
	return @"unknown";
}

- (NSString*) descriptionString
{
	if(self.IsDerivedValue)
	{
		return self.derivedString;
	}
	
	return [FLZfAccessDescriptor accessTypeString:self.AccessTypeValue];
}

- (FLZfAccessUpdater*) createUpdater
{
	FLZfAccessUpdater* accessUpdate = FLAutorelease([[FLZfAccessUpdater alloc] init]);
	accessUpdate.IsDerivedValue = self.IsDerivedValue;
	if(!accessUpdate.IsDerivedValue)
	{
		accessUpdate.AccessType = self.AccessType;

		FLZfAccessType accessType = accessUpdate.AccessTypeValue;
		if(accessType == FLZfAccessTypePassword)
		{
			accessUpdate.Password = self.password;
		}
		else if(accessType == FLZfAccessTypeUserList)
		{
			accessUpdate.Viewers = self.Viewers;
		}
	}
	
	accessUpdate.AccessMask = self.AccessMask;
	if(FLStringIsEmpty(accessUpdate.AccessMask))
	{
		accessUpdate.AccessMask = kZfApiAccessMaskNone;
	}
	
	return accessUpdate;
}

- (BOOL) testAccessMask:(FLZfApiAccessMask) mask
{
	return [self.AccessMask rangeOfString:[[FLZfApi1_6EnumLookup instance] stringFromApiAccessMask:mask]].length > 0;
}

- (BOOL) protectExtraExtraLarge
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectXXLarge];
}
- (BOOL) protectExtraLarge
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectExtraLarge];
}
- (BOOL) protectLarge
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectLarge];
}
- (BOOL) protectMedium
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectMedium];
}
- (BOOL) protectOriginals
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectOriginals];
}
- (BOOL) protectAll
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectAll];
}
- (BOOL) noCollections
{
	return	[self testAccessMask:FLZfApiAccessMaskNoCollections];
}
- (BOOL) noPrivateSearch
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPrivateSearch];
}
- (BOOL) noPublicSearch
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPublicSearch];
}
- (BOOL) hideDateCreated
{
	return	[self testAccessMask:FLZfApiAccessMaskHideDateCreated];
}
- (BOOL) hideDateModified
{
	return	[self testAccessMask:FLZfApiAccessMaskHideDateModified];
}
- (BOOL) protectExif
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectExif];
}
- (BOOL) hideMetaData
{
	return	[self testAccessMask:FLZfApiAccessMaskHideMetaData];
}
- (BOOL) hideVisits
{
	return	[self testAccessMask:FLZfApiAccessMaskHideVisits];
}
- (BOOL) hideUserStats
{
	return	[self testAccessMask:FLZfApiAccessMaskHideUserStats];
}
- (BOOL) noPublicGuestbookPosts
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPublicGuestbookPosts];
}
- (BOOL) noPrivateGuestBookPosts
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPrivateGuestbookPosts];
}
- (BOOL) noAnonymouseGuestbookPosts
{
	return	[self testAccessMask:FLZfApiAccessMaskNoAnonymousGuestbookPosts];
}
- (BOOL) noPublicComments
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPublicComments];
}
- (BOOL) noPrivateComments
{
	return	[self testAccessMask:FLZfApiAccessMaskNoPrivateComments];
}
- (BOOL) noAnonymousComments
{
	return	[self testAccessMask:FLZfApiAccessMaskNoAnonymousComments];
}
- (BOOL) protectComments
{
	return	[self testAccessMask:FLZfApiAccessMaskProtectComments];
}

- (FLZfImageSize*) largestAllowedImageSize
{
//    if(self.protectAll) 
//    {
//        return kNoPhoto;
//    }
//    
    if(self.protectMedium)
    {
        return [FLZfImageSize smallImageSize];
    }
    
    if(self.protectLarge)
    {
        return [FLZfImageSize mediumImageSize];
    }
    
    if(self.protectExtraLarge)
    {
        return [FLZfImageSize largeImageSize];
    }
    
    if(self.protectExtraExtraLarge)
    {
        return [FLZfImageSize xLargeImageSize];
    }
    
    if(self.protectOriginals) {
        return [FLZfImageSize xxLargeImageSize];
    }
    
    return [FLZfImageSize originalImageSize];
    
}

- (void) setProtectExtraExtraLarge:(BOOL) download
{
// TODO: use new enum stuff???

	if(download)
	{
		if(FLStringIsNotEmpty(self.AccessMask))
		{
			self.AccessMask = [self.AccessMask stringByRemovingUniqueWord:kZfApiAccessMaskProtectXXLarge];
		}
	}
	else
	{
		if(FLStringIsEmpty(self.AccessMask))
		{
			self.AccessMask = kZfApiAccessMaskProtectXXLarge;
		}
		else
		{
			self.AccessMask = [self.AccessMask stringByRemovingUniqueWord:kZfApiAccessMaskNone];
		
			self.AccessMask = [self.AccessMask stringByAddingUniqueWord:kZfApiAccessMaskProtectXXLarge];
		}	 
	}
}

+ (NSString*) displayFormatterDataToString:(id) data
{
 	if(data == nil)
	{
		return NSLocalizedString(@"Default", nil);
	}

	return [data descriptionString];
}

@end
