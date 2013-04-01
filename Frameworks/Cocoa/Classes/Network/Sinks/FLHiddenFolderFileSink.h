//
//  FLHiddenFolderFileSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFileSink.h"

@interface FLHiddenFolderFileSink : FLFileSink {
@private
    NSURL* _folderURL;
    NSURL* _tempFileURL;
    NSURL* _destinationFileURL;
}

- (id) initWithFileURL:(NSURL*) fileURL folderURL:(NSURL*) folderURL;

+ (id) hiddenFolderFileSink:(NSURL*) fileURL folderURL:(NSURL*) folderURL;

@end
