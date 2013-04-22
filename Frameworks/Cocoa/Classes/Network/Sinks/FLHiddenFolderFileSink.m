//
//  FLHiddenFolderFileSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHiddenFolderFileSink.h"

@interface FLHiddenFolderFileSink ()
@property (readwrite, strong, nonatomic) NSString* folderPath;
@property (readwrite, strong, nonatomic) NSString* destinationFilePath;
@property (readwrite, strong, nonatomic) NSString* tempFilePath;

@end

@implementation FLHiddenFolderFileSink

@synthesize folderPath = _folderPath;
@synthesize destinationFilePath = _destinationFilePath;
@synthesize tempFilePath = _tempFilePath;

- (id) initWithFilePath:(NSString*) filePath folderPath:(NSString*) folderPath {
    
    NSString* tempFilePath = [folderPath stringByAppendingPathComponent:[filePath lastPathComponent]];

    self = [super initWithFilePath:tempFilePath];
    if(self) {
        self.tempFilePath = tempFilePath;
        self.destinationFilePath = filePath;
        self.folderPath = folderPath;
    }
    return self;
}

+ (id) hiddenFolderFileSink:(NSString*) filePath folderPath:(NSString*) folderPath {
    return FLAutorelease([[[self class] alloc] initWithFilePath:filePath folderPath:folderPath]); 
}

#if FL_MRC
- (void) dealloc {
    [_tempFilePath release];
    [_destinationFilePath release];
    [_folderPath release];
	[super dealloc];
}
#endif

- (void) openSink {

    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:self.folderPath withIntermediateDirectories:YES attributes:nil error:&error];
    FLThrowIfError(error);

    [super openSink];
}

- (void) closeSinkWithCommit:(BOOL) commit {
    
    [super closeSinkWithCommit:commit];
    
    if(commit) {
        NSError* error = nil;
        [[NSFileManager defaultManager] moveItemAtPath:self.tempFilePath toPath:self.destinationFilePath error:&error];
        
        FLThrowIfError(error);
    }
}

@end
