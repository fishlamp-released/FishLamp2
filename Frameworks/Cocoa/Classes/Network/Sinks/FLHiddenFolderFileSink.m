//
//  FLHiddenFolderFileSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHiddenFolderFileSink.h"

@interface FLHiddenFolderFileSink ()
@property (readwrite, strong, nonatomic) NSURL* folderURL;
@property (readwrite, strong, nonatomic) NSURL* destinationFileURL;
@property (readwrite, strong, nonatomic) NSURL* tempFileURL;

@end

@implementation FLHiddenFolderFileSink

@synthesize folderURL = _folderURL;
@synthesize destinationFileURL = _destinationFileURL;
@synthesize tempFileURL = _tempFileURL;

- (id) initWithFileURL:(NSURL*) fileURL folderURL:(NSURL*) folderURL {
    
    NSURL* tempFileURL = [folderURL URLByAppendingPathComponent:[fileURL lastPathComponent]];

    self = [super initWithFileURL:tempFileURL];
    if(self) {
        self.tempFileURL = tempFileURL;
        self.destinationFileURL = fileURL;
        self.folderURL = folderURL;
    }
    return self;
}

+ (id) hiddenFolderFileSink:(NSURL*) fileURL folderURL:(NSURL*) folderURL {
    return FLAutorelease([[[self class] alloc] initWithFileURL:fileURL folderURL:folderURL]); 
}

#if FL_MRC
- (void) dealloc {
    [_tempFileURL release];
    [_destinationFileURL release];
    [_folderURL release];
	[super dealloc];
}
#endif

- (void) openSink {

 //   BOOL isDirectory = NO;
    NSError* error = nil;
    NSString* path = [self.folderURL path];
//    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    FLThrowIfError(error);

    [super openSink];
}


- (void) commit {
    [super commit];
    
    NSError* error = nil;
    [[NSFileManager defaultManager] moveItemAtURL:self.tempFileURL toURL:self.destinationFileURL error:&error];
    
    FLThrowIfError(error);
}

@end
