//
//  ZFDownloadPhotoSetsOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadPhotoSetsOperation.h"
#import "ZFHttpRequest.h"

@interface ZFDownloadPhotoSetsOperation ()
@property (readwrite, strong) ZFGroup* group;
@end

@implementation ZFDownloadPhotoSetsOperation

@synthesize group = _group;

#if FL_MRC
- (void) dealloc {

    [_group release];
      [super dealloc];
}
#endif


- (id) initWithGroup:(ZFGroup*) group {
    self = [super init];
    if(self) {
        self.group = group;
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(ZFGroup*) group {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
}

- (void) runForGroup:(ZFGroup*) group {
    NSMutableArray* newList = [NSMutableArray array];
    for(ZFGroupElement* element in group.Elements) {
        if(element.isGroupElement) {
            [self runForGroup:(ZFGroup*) element];
            [newList addObject:element];
        }
        else {
            FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:element.Id level:kZfInformatonLevelFull includePhotos:NO];
            ZFPhotoSet* set = [request sendSynchronouslyInContext:self.context];
            FLAssertNotNil_(set)
            [newList addObject:set];
            
//            [self postObservation:@selector(photoSetDownloader:didDownloadPhotoSet:) withObject:set];
        }
    }
    group.Elements = newList;
}

- (FLResult) runOperation {
    [self runForGroup:_group];
    return _group;
}


@end
