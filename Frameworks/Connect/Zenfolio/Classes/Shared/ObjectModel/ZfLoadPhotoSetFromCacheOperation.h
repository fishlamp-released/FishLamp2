//
//  ZFLoadPhotoSetFromCacheOperation.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCachedObjectOperation.h"

@interface ZFLoadPhotoSetFromCacheOperation : FLCachedObjectOperation<FLCacheObjectOperationSubclass> {
@private
    int _photoSetID;
    int _textCn;
    int _photoListCn;
}
- (id) initWithPhotoSetId:(int) photoSetId
                   textCn:(int) textCn
              photoListCn:(int) photoListCn;

@end
