//
//	FLZenfolioFavoritesSetManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/11/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR


#import <Foundation/Foundation.h>
#import "FLZenfolioSharedFavoritesSet.h"
#import "FLBatchActionManager.h"
#import "FLService.h"

@interface FLZenfolioSharedFavoritesSetManager : FLService {

}

FLSingletonProperty(FLZenfolioSharedFavoritesSetManager);

- (void) saveSharedFavoritesSet:(FLZenfolioSharedFavoritesSet*) set;

- (NSArray*) loadAllSharedFavorites;

- (void) uploadSavedFavoritesSetsIfNeeded:(FLOperationContext*) actionContext;

@end

@interface FLZenfolioSaveAllSharedFavorites : FLBatchActionManager {
	FLZenfolioSharedFavoritesSet* _lastSharedFavorite;
	BOOL _showProgress;
}
@property (readonly, retain, nonatomic) FLZenfolioSharedFavoritesSet* lastSharedFavorite;
@property (readwrite, assign, nonatomic) BOOL showProgress;

@end

#endif