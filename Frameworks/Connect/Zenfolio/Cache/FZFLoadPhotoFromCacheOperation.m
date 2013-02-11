//
//  FLZenfolioLoadPhotoFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadPhotoFromCacheOperation.h"
#import "FLZenfolioHttpRequest.h"
#import "FLZenfolioCacheService.h"

@implementation FLZenfolioLoadPhotoFromCacheOperation 

- (id) initWithPhotoId:(int) photoId 
                 level:(NSString*) level 
                textCn:(int) textCn 
              sequence:(NSString*) sequence {
    self = [super init];
	if(self) {
        _level = FLRetain(level);
        _textCn = textCn;
        _photoID = photoId;
        _sequence = FLRetain(sequence);
	}
	
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_sequence release];
    [_level release];
    [super dealloc];
}
#endif

- (FLResult) runSubOperations {

    FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoHttpRequest:[NSNumber numberWithInt:_photoID] level:_level];

    return [request sendSynchronouslyInContext:self.context];
}

- (id) loadObjectFromDatabase {
    FLZenfolioCacheService* service = [self.context cacheService];
    
    FLZenfolioPhoto* photo = [service loadPhotoWithID:_photoID];
    if(!photo) {
        return nil;
    }
    
	self.alwaysRunSubOperations = [photo isStaleComparedTo:_textCn sequence:_sequence];
	
	return photo;
}

- (void) saveObjectToDatabase:(id) object {
    [ [self.context cacheService] savePhoto:object];
}

@end