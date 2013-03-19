//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoap.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApiSoap.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioApiSoap


FLSynthesizeSingleton(FLZenfolioApiSoap);

+ (FLZenfolioApiSoap*) apiSoap
{
	return FLAutorelease([[FLZenfolioApiSoap alloc] init]);
}

- (id) init
{
	if((self = [super init]))
	{
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetCategories" forKey:@"GetCategories"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdatePhotoSet" forKey:@"UpdatePhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetPopularPhotos" forKey:@"GetPopularPhotos"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdatePhotoAccess" forKey:@"UpdatePhotoAccess"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetVisitorKey" forKey:@"GetVisitorKey"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/MovePhoto" forKey:@"MovePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CreatePhotoSet" forKey:@"CreatePhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadSharedFavoritesSets" forKey:@"LoadSharedFavoritesSets"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetVersion" forKey:@"GetVersion"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetRecentSets" forKey:@"GetRecentSets"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CollectionRemovePhoto" forKey:@"CollectionRemovePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SearchPhotoByCategory" forKey:@"SearchPhotoByCategory"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/MoveGroup" forKey:@"MoveGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ReplacePhoto" forKey:@"ReplacePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SearchSetByCategory" forKey:@"SearchSetByCategory"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SetPhotoSetFeaturedIndex" forKey:@"SetPhotoSetFeaturedIndex"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/DeleteMessage" forKey:@"DeleteMessage"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetDownloadOriginalKey" forKey:@"GetDownloadOriginalKey"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetPopularSets" forKey:@"GetPopularSets"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/AuthenticateVisitor" forKey:@"AuthenticateVisitor"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/zfapi.asmx" forKey:@"url"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadPhotoSet" forKey:@"LoadPhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadMessages" forKey:@"LoadMessages"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/AuthenticatePlain" forKey:@"AuthenticatePlain"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6" forKey:@"namespace"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SearchSetByText" forKey:@"SearchSetByText"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdatePhotoSetAccess" forKey:@"UpdatePhotoSetAccess"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SetPhotoSetTitlePhoto" forKey:@"SetPhotoSetTitlePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/DeletePhoto" forKey:@"DeletePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/DeletePhotoSet" forKey:@"DeletePhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SetGroupTitlePhoto" forKey:@"SetGroupTitlePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadPhoto" forKey:@"LoadPhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdateGroupAccess" forKey:@"UpdateGroupAccess"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadAccessRealm" forKey:@"LoadAccessRealm"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CreateFavoritesSet" forKey:@"CreateFavoritesSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ReorderGroup" forKey:@"ReorderGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/DeleteGroup" forKey:@"DeleteGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadGroup" forKey:@"LoadGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CollectionAddPhoto" forKey:@"CollectionAddPhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UndeleteMessage" forKey:@"UndeleteMessage"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ResolveReference" forKey:@"ResolveReference"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/SearchPhotoByText" forKey:@"SearchPhotoByText"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/MovePhotoSet" forKey:@"MovePhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadGroupHierarchy" forKey:@"LoadGroupHierarchy"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CreatePhotoFromUrl" forKey:@"CreatePhotoFromUrl"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetRecentPhotos" forKey:@"GetRecentPhotos"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadPhotoSetPhotos" forKey:@"LoadPhotoSetPhotos"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadPublicProfile" forKey:@"LoadPublicProfile"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdatePhoto" forKey:@"UpdatePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetVideoPlaybackUrl" forKey:@"GetVideoPlaybackUrl"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ReindexPhotoSet" forKey:@"ReindexPhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/KeyringAddKeyPlain" forKey:@"KeyringAddKeyPlain"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/AddMessage" forKey:@"AddMessage"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/RotatePhoto" forKey:@"RotatePhoto"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/UpdateGroup" forKey:@"UpdateGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/LoadPrivateProfile" forKey:@"LoadPrivateProfile"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/KeyringGetUnlockedRealms" forKey:@"KeyringGetUnlockedRealms"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CheckPrivilege" forKey:@"CheckPrivilege"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CreateVideoFromUrl" forKey:@"CreateVideoFromUrl"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/CreateGroup" forKey:@"CreateGroup"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ReorderPhotoSet" forKey:@"ReorderPhotoSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/Authenticate" forKey:@"Authenticate"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/ShareFavoritesSet" forKey:@"ShareFavoritesSet"];
		[self.properties setObject:@"http://www.zenfolio.com/api/1.6/GetChallenge" forKey:@"GetChallenge"];
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
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
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

@implementation FLZenfolioApiSoap (ValueProperties) 
@end

