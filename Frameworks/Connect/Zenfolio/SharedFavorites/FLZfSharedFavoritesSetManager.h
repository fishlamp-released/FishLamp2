//
//	FLZfFavoritesSetManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/11/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR


#import <Foundation/Foundation.h>
#import "FLZfSharedFavoritesSet.h"
#import "FLBatchActionManager.h"
#import "FLService.h"

@interface FLZfSharedFavoritesSetManager : FLService {

}

FLSingletonProperty(FLZfSharedFavoritesSetManager);

- (void) saveSharedFavoritesSet:(FLZfSharedFavoritesSet*) set;

- (NSArray*) loadAllSharedFavorites;

- (void) uploadSavedFavoritesSetsIfNeeded:(FLOperationContext*) actionContext;

@end

@interface FLZfSaveAllSharedFavorites : FLBatchActionManager {
	FLZfSharedFavoritesSet* _lastSharedFavorite;
	BOOL _showProgress;
}
@property (readonly, retain, nonatomic) FLZfSharedFavoritesSet* lastSharedFavorite;
@property (readwrite, assign, nonatomic) BOOL showProgress;

@end

#endif