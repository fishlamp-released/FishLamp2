//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiHttpGet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioApiHttpGet


FLSynthesizeSingleton(FLZenfolioApiHttpGet);

+ (FLZenfolioApiHttpGet*) apiHttpGet
{
	return FLAutorelease([[FLZenfolioApiHttpGet alloc] init]);
}

- (id) init
{
	if((self = [super init]))
	{
		[self.properties setObject:@"/GetCategories" forKey:@"GetCategories"];
		[self.properties setObject:@"/GetVisitorKey" forKey:@"GetVisitorKey"];
		[self.properties setObject:@"/LoadSharedFavoritesSets" forKey:@"LoadSharedFavoritesSets"];
		[self.properties setObject:@"/GetPopularPhotos" forKey:@"GetPopularPhotos"];
		[self.properties setObject:@"/MovePhoto" forKey:@"MovePhoto"];
		[self.properties setObject:@"/GetVersion" forKey:@"GetVersion"];
		[self.properties setObject:@"/GetRecentSets" forKey:@"GetRecentSets"];
		[self.properties setObject:@"/CollectionRemovePhoto" forKey:@"CollectionRemovePhoto"];
		[self.properties setObject:@"/SearchPhotoByCategory" forKey:@"SearchPhotoByCategory"];
		[self.properties setObject:@"/MoveGroup" forKey:@"MoveGroup"];
		[self.properties setObject:@"/ReplacePhoto" forKey:@"ReplacePhoto"];
		[self.properties setObject:@"/SearchSetByCategory" forKey:@"SearchSetByCategory"];
		[self.properties setObject:@"/SetPhotoSetFeaturedIndex" forKey:@"SetPhotoSetFeaturedIndex"];
		[self.properties setObject:@"/DeleteMessage" forKey:@"DeleteMessage"];
		[self.properties setObject:@"/GetDownloadOriginalKey" forKey:@"GetDownloadOriginalKey"];
		[self.properties setObject:@"/GetPopularSets" forKey:@"GetPopularSets"];
		[self.properties setObject:@"/AuthenticateVisitor" forKey:@"AuthenticateVisitor"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/zfapi.asmx" forKey:@"url"];
		[self.properties setObject:@"/LoadPhotoSet" forKey:@"LoadPhotoSet"];
		[self.properties setObject:@"/LoadMessages" forKey:@"LoadMessages"];
		[self.properties setObject:@"/AuthenticatePlain" forKey:@"AuthenticatePlain"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6" forKey:@"namespace"];
		[self.properties setObject:@"/SearchSetByText" forKey:@"SearchSetByText"];
		[self.properties setObject:@"/SetPhotoSetTitlePhoto" forKey:@"SetPhotoSetTitlePhoto"];
		[self.properties setObject:@"/DeletePhoto" forKey:@"DeletePhoto"];
		[self.properties setObject:@"/DeletePhotoSet" forKey:@"DeletePhotoSet"];
		[self.properties setObject:@"/SetGroupTitlePhoto" forKey:@"SetGroupTitlePhoto"];
		[self.properties setObject:@"/CreateFavoritesSet" forKey:@"CreateFavoritesSet"];
		[self.properties setObject:@"/LoadPhoto" forKey:@"LoadPhoto"];
		[self.properties setObject:@"/LoadAccessRealm" forKey:@"LoadAccessRealm"];
		[self.properties setObject:@"/ReorderGroup" forKey:@"ReorderGroup"];
		[self.properties setObject:@"/DeleteGroup" forKey:@"DeleteGroup"];
		[self.properties setObject:@"/LoadGroup" forKey:@"LoadGroup"];
		[self.properties setObject:@"/UndeleteMessage" forKey:@"UndeleteMessage"];
		[self.properties setObject:@"/CollectionAddPhoto" forKey:@"CollectionAddPhoto"];
		[self.properties setObject:@"/ResolveReference" forKey:@"ResolveReference"];
		[self.properties setObject:@"/SearchPhotoByText" forKey:@"SearchPhotoByText"];
		[self.properties setObject:@"/MovePhotoSet" forKey:@"MovePhotoSet"];
		[self.properties setObject:@"/LoadGroupHierarchy" forKey:@"LoadGroupHierarchy"];
		[self.properties setObject:@"/CreatePhotoFromUrl" forKey:@"CreatePhotoFromUrl"];
		[self.properties setObject:@"/GetRecentPhotos" forKey:@"GetRecentPhotos"];
		[self.properties setObject:@"/LoadPhotoSetPhotos" forKey:@"LoadPhotoSetPhotos"];
		[self.properties setObject:@"/LoadPublicProfile" forKey:@"LoadPublicProfile"];
		[self.properties setObject:@"/GetVideoPlaybackUrl" forKey:@"GetVideoPlaybackUrl"];
		[self.properties setObject:@"/ReindexPhotoSet" forKey:@"ReindexPhotoSet"];
		[self.properties setObject:@"/KeyringAddKeyPlain" forKey:@"KeyringAddKeyPlain"];
		[self.properties setObject:@"/RotatePhoto" forKey:@"RotatePhoto"];
		[self.properties setObject:@"/KeyringGetUnlockedRealms" forKey:@"KeyringGetUnlockedRealms"];
		[self.properties setObject:@"/CheckPrivilege" forKey:@"CheckPrivilege"];
		[self.properties setObject:@"/LoadPrivateProfile" forKey:@"LoadPrivateProfile"];
		[self.properties setObject:@"/CreateVideoFromUrl" forKey:@"CreateVideoFromUrl"];
		[self.properties setObject:@"/ShareFavoritesSet" forKey:@"ShareFavoritesSet"];
		[self.properties setObject:@"/ReorderPhotoSet" forKey:@"ReorderPhotoSet"];
		[self.properties setObject:@"/Authenticate" forKey:@"Authenticate"];
		[self.properties setObject:@"/GetChallenge" forKey:@"GetChallenge"];
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
	});
	return s_table;
}

@end

@implementation FLZenfolioApiHttpGet (ValueProperties) 
@end

