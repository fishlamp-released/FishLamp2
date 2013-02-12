//
//  FLZenfolioAccessDescriptor+More.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioAccessDescriptor+More.h"
#import "NSString+Lists.h"

@implementation FLZenfolioAccessDescriptor (More)

- (NSString*) derivedString
{
	return NSLocalizedString(@"Same as Container", nil);
}

+ (NSString*) accessTypeString:(FLZenfolioAccessType) accessType
{
	switch(accessType)
	{
		case FLZenfolioAccessTypePrivate:
			return NSLocalizedString(@"Private", nil);
		break;
		case FLZenfolioAccessTypeUserList:
			return NSLocalizedString(@"Allowed Zenfolio users only", nil);
		break;
		case FLZenfolioAccessTypePassword:
			return NSLocalizedString(@"Locked with password", nil);
		break;
		case FLZenfolioAccessTypePublic:
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
	
	return [FLZenfolioAccessDescriptor accessTypeString:self.AccessTypeValue];
}

- (FLZenfolioAccessUpdater*) createUpdater
{
	FLZenfolioAccessUpdater* accessUpdate = FLAutorelease([[FLZenfolioAccessUpdater alloc] init]);
	accessUpdate.IsDerivedValue = self.IsDerivedValue;
	if(!accessUpdate.IsDerivedValue)
	{
		accessUpdate.AccessType = self.AccessType;

		FLZenfolioAccessType accessType = accessUpdate.AccessTypeValue;
		if(accessType == FLZenfolioAccessTypePassword)
		{
			accessUpdate.Password = self.password;
		}
		else if(accessType == FLZenfolioAccessTypeUserList)
		{
			accessUpdate.Viewers = self.Viewers;
		}
	}
	
	accessUpdate.AccessMask = self.AccessMask;
	if(FLStringIsEmpty(accessUpdate.AccessMask))
	{
		accessUpdate.AccessMask = kZenfolioApiAccessMaskNone;
	}
	
	return accessUpdate;
}

- (BOOL) testAccessMask:(FLZenfolioApiAccessMask) mask
{
	return [self.AccessMask rangeOfString:[[FLZenfolioApi1_6EnumLookup instance] stringFromApiAccessMask:mask]].length > 0;
}

- (BOOL) protectExtraExtraLarge
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectXXLarge];
}
- (BOOL) protectExtraLarge
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectExtraLarge];
}
- (BOOL) protectLarge
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectLarge];
}
- (BOOL) protectMedium
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectMedium];
}
- (BOOL) protectOriginals
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectOriginals];
}
- (BOOL) protectAll
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectAll];
}
- (BOOL) noCollections
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoCollections];
}
- (BOOL) noPrivateSearch
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPrivateSearch];
}
- (BOOL) noPublicSearch
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPublicSearch];
}
- (BOOL) hideDateCreated
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskHideDateCreated];
}
- (BOOL) hideDateModified
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskHideDateModified];
}
- (BOOL) protectExif
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectExif];
}
- (BOOL) hideMetaData
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskHideMetaData];
}
- (BOOL) hideVisits
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskHideVisits];
}
- (BOOL) hideUserStats
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskHideUserStats];
}
- (BOOL) noPublicGuestbookPosts
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPublicGuestbookPosts];
}
- (BOOL) noPrivateGuestBookPosts
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPrivateGuestbookPosts];
}
- (BOOL) noAnonymouseGuestbookPosts
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoAnonymousGuestbookPosts];
}
- (BOOL) noPublicComments
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPublicComments];
}
- (BOOL) noPrivateComments
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoPrivateComments];
}
- (BOOL) noAnonymousComments
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskNoAnonymousComments];
}
- (BOOL) protectComments
{
	return	[self testAccessMask:FLZenfolioApiAccessMaskProtectComments];
}

- (FLZenfolioImageSize*) largestAllowedImageSize
{
//    if(self.protectAll) 
//    {
//        return kNoPhoto;
//    }
//    
    if(self.protectMedium)
    {
        return [FLZenfolioImageSize smallImageSize];
    }
    
    if(self.protectLarge)
    {
        return [FLZenfolioImageSize mediumImageSize];
    }
    
    if(self.protectExtraLarge)
    {
        return [FLZenfolioImageSize largeImageSize];
    }
    
    if(self.protectExtraExtraLarge)
    {
        return [FLZenfolioImageSize xLargeImageSize];
    }
    
    if(self.protectOriginals) {
        return [FLZenfolioImageSize xxLargeImageSize];
    }
    
    return [FLZenfolioImageSize originalImageSize];
    
}

- (void) setProtectExtraExtraLarge:(BOOL) download
{
// TODO: use new enum stuff???

	if(download)
	{
		if(FLStringIsNotEmpty(self.AccessMask))
		{
			self.AccessMask = [self.AccessMask stringByRemovingUniqueWord:kZenfolioApiAccessMaskProtectXXLarge];
		}
	}
	else
	{
		if(FLStringIsEmpty(self.AccessMask))
		{
			self.AccessMask = kZenfolioApiAccessMaskProtectXXLarge;
		}
		else
		{
			self.AccessMask = [self.AccessMask stringByRemovingUniqueWord:kZenfolioApiAccessMaskNone];
		
			self.AccessMask = [self.AccessMask stringByAddingUniqueWord:kZenfolioApiAccessMaskProtectXXLarge];
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
