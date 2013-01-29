//
//  FLZfDownloadPhotoSetsOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfDownloadPhotoSetsOperation.h"
#import "FLZfHttpRequest.h"

@interface FLZfDownloadPhotoSetsOperation ()
@property (readwrite, strong) FLZfGroup* group;
@end

@implementation FLZfDownloadPhotoSetsOperation

@synthesize group = _group;

#if FL_MRC
- (void) dealloc {

    [_group release];
      [super dealloc];
}
#endif


- (id) initWithGroup:(FLZfGroup*) group {
    self = [super init];
    if(self) {
        self.group = group;
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(FLZfGroup*) group {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
}

- (void) runForGroup:(FLZfGroup*) group {
    NSMutableArray* newList = [NSMutableArray array];
    for(FLZfGroupElement* element in group.Elements) {
        if(element.isGroupElement) {
            [self runForGroup:(FLZfGroup*) element];
            [newList addObject:element];
        }
        else {
            FLHttpRequest* request = [FLZfHttpRequest loadPhotoSetHttpRequest:element.Id level:kZfInformatonLevelFull includePhotos:NO];
            FLZfPhotoSet* set = [request sendSynchronouslyInContext:self.context];
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
