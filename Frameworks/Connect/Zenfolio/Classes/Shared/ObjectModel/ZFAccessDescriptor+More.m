//
//  ZFAccessDescriptor+More.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFAccessDescriptor+More.h"
#import "NSString+Lists.h"

@implementation ZFAccessDescriptor (More)

- (NSString*) derivedString
{
	return NSLocalizedString(@"Same as Container", nil);
}

+ (NSString*) accessTypeString:(ZFAccessType) accessType
{
	switch(accessType)
	{
		case ZFAccessTypePrivate:
			return NSLocalizedString(@"Private", nil);
		break;
		case ZFAccessTypeUserList:
			return NSLocalizedString(@"Allowed Zenfolio users only", nil);
		break;
		case ZFAccessTypePassword:
			return NSLocalizedString(@"Locked with password", nil);
		break;
		case ZFAccessTypePublic:
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
	
	return [ZFAccessDescriptor accessTypeString:self.AccessTypeValue];
}

- (ZFAccessUpdater*) createUpdater
{
	ZFAccessUpdater* accessUpdate = FLAutorelease([[ZFAccessUpdater alloc] init]);
	accessUpdate.IsDerivedValue = self.IsDerivedValue;
	if(!accessUpdate.IsDerivedValue)
	{
		accessUpdate.AccessType = self.AccessType;

		ZFAccessType accessType = accessUpdate.AccessTypeValue;
		if(accessType == ZFAccessTypePassword)
		{
			accessUpdate.Password = self.password;
		}
		else if(accessType == ZFAccessTypeUserList)
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

- (BOOL) testAccessMask:(ZFApiAccessMask) mask
{
	return [self.AccessMask rangeOfString:[[ZFApi1_6EnumLookup instance] stringFromApiAccessMask:mask]].length > 0;
}

- (BOOL) protectExtraExtraLarge
{
	return	[self testAccessMask:ZFApiAccessMaskProtectXXLarge];
}
- (BOOL) protectExtraLarge
{
	return	[self testAccessMask:ZFApiAccessMaskProtectExtraLarge];
}
- (BOOL) protectLarge
{
	return	[self testAccessMask:ZFApiAccessMaskProtectLarge];
}
- (BOOL) protectMedium
{
	return	[self testAccessMask:ZFApiAccessMaskProtectMedium];
}
- (BOOL) protectOriginals
{
	return	[self testAccessMask:ZFApiAccessMaskProtectOriginals];
}
- (BOOL) protectAll
{
	return	[self testAccessMask:ZFApiAccessMaskProtectAll];
}
- (BOOL) noCollections
{
	return	[self testAccessMask:ZFApiAccessMaskNoCollections];
}
- (BOOL) noPrivateSearch
{
	return	[self testAccessMask:ZFApiAccessMaskNoPrivateSearch];
}
- (BOOL) noPublicSearch
{
	return	[self testAccessMask:ZFApiAccessMaskNoPublicSearch];
}
- (BOOL) hideDateCreated
{
	return	[self testAccessMask:ZFApiAccessMaskHideDateCreated];
}
- (BOOL) hideDateModified
{
	return	[self testAccessMask:ZFApiAccessMaskHideDateModified];
}
- (BOOL) protectExif
{
	return	[self testAccessMask:ZFApiAccessMaskProtectExif];
}
- (BOOL) hideMetaData
{
	return	[self testAccessMask:ZFApiAccessMaskHideMetaData];
}
- (BOOL) hideVisits
{
	return	[self testAccessMask:ZFApiAccessMaskHideVisits];
}
- (BOOL) hideUserStats
{
	return	[self testAccessMask:ZFApiAccessMaskHideUserStats];
}
- (BOOL) noPublicGuestbookPosts
{
	return	[self testAccessMask:ZFApiAccessMaskNoPublicGuestbookPosts];
}
- (BOOL) noPrivateGuestBookPosts
{
	return	[self testAccessMask:ZFApiAccessMaskNoPrivateGuestbookPosts];
}
- (BOOL) noAnonymouseGuestbookPosts
{
	return	[self testAccessMask:ZFApiAccessMaskNoAnonymousGuestbookPosts];
}
- (BOOL) noPublicComments
{
	return	[self testAccessMask:ZFApiAccessMaskNoPublicComments];
}
- (BOOL) noPrivateComments
{
	return	[self testAccessMask:ZFApiAccessMaskNoPrivateComments];
}
- (BOOL) noAnonymousComments
{
	return	[self testAccessMask:ZFApiAccessMaskNoAnonymousComments];
}
- (BOOL) protectComments
{
	return	[self testAccessMask:ZFApiAccessMaskProtectComments];
}

- (ZFImageSize*) largestAllowedImageSize
{
//    if(self.protectAll) 
//    {
//        return kNoPhoto;
//    }
//    
    if(self.protectMedium)
    {
        return [ZFImageSize smallImageSize];
    }
    
    if(self.protectLarge)
    {
        return [ZFImageSize mediumImageSize];
    }
    
    if(self.protectExtraLarge)
    {
        return [ZFImageSize largeImageSize];
    }
    
    if(self.protectExtraExtraLarge)
    {
        return [ZFImageSize xLargeImageSize];
    }
    
    if(self.protectOriginals) {
        return [ZFImageSize xxLargeImageSize];
    }
    
    return [ZFImageSize originalImageSize];
    
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
