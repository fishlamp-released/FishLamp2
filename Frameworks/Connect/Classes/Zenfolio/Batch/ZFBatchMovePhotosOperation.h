//
//  ZFBatchMovePhotosOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFBatchOperation.h"

@interface ZFBatchMovePhotosOperation : FLBatchOperation {
@private
	ZFPhotoSet* _parentPhotoSet;
	ZFPhotoSet* _destPhotoSet;
}

- (id) initWithPhotoArray:(NSArray*) photos
               moveFromPhotoSet:(ZFPhotoSet*) moveFrom
                 moveToPhotoSet:(ZFPhotoSet*) moveTo;

+ (id) batchMovePhotosOperation:(NSArray*) photos
               moveFromPhotoSet:(ZFPhotoSet*) moveFrom
                 moveToPhotoSet:(ZFPhotoSet*) moveTo;

@end
