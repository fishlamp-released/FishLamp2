//
//  FLZfBatchMovePhotosOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfBatchOperation.h"

@interface FLZfBatchMovePhotosOperation : FLBatchOperation {
@private
	FLZfPhotoSet* _parentPhotoSet;
	FLZfPhotoSet* _destPhotoSet;
}

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(FLZfPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZfPhotoSet*) moveTo;

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(FLZfPhotoSet*) moveFrom
                 moveToPhotoSet:(FLZfPhotoSet*) moveTo;

@end
