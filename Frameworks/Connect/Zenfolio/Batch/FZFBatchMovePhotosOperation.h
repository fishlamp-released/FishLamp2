//
//  FLZenfolioBatchMovePhotosOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioBatchOperation.h"

@interface FLZenfolioBatchMovePhotosOperation : FLBatchOperation {
@private
	FLZenfolioPhotoSet* _parentPhotoSet;
	FLZenfolioPhotoSet* _destPhotoSet;
}

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(FLZenfolioPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZenfolioPhotoSet*) moveTo;

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(FLZenfolioPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZenfolioPhotoSet*) moveTo;

@end
