//
//  FLStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@protocol FLBlobStorage <NSObject>
- (void) writeBlob:(id) identifier;
- (id) readBlob:(id) identifier;
- (void) deleteBlob:(id) identifier;
- (BOOL) containsBlob:(id) identifier;
@end

@protocol FLBlobIdentifier <NSObject>
- (NSString*) relativePathIdentifier;
- (id) uniqueIdentifier;
@end

@interface FLBlobIdentifier : NSObject<FLBlobIdentifier> {
@private
    NSString* _relativePath;
    NSString* _uniqueIdentifier;
}
@property (readwrite, strong, nonatomic) NSString* relativePathIdentifier;
@property (readwrite, strong, nonatomic) id uniqueIdentifier;

@end