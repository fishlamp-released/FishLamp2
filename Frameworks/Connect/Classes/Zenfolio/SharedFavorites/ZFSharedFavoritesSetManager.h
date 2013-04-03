//
//	ZFFavoritesSetManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/11/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR


#import <Foundation/Foundation.h>
#import "ZFSharedFavoritesSet.h"
#import "FLBatchActionManager.h"
#import "FLService.h"

@interface ZFSharedFavoritesSetManager : FLService {

}

FLSingletonProperty(ZFSharedFavoritesSetManager);

- (void) saveSharedFavoritesSet:(ZFSharedFavoritesSet*) set;

- (NSArray*) loadAllSharedFavorites;

- (void) uploadSavedFavoritesSetsIfNeeded:(FLOperationContext*) actionContext;

@end

@interface ZFSaveAllSharedFavorites : FLBatchActionManager {
	ZFSharedFavoritesSet* _lastSharedFavorite;
	BOOL _showProgress;
}
@property (readonly, retain, nonatomic) ZFSharedFavoritesSet* lastSharedFavorite;
@property (readwrite, assign, nonatomic) BOOL showProgress;

@end

#endif