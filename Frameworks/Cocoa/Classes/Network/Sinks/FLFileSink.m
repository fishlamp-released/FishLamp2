//
//  FLFileSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFileSink.h"

@interface FLFileSink ()
@property (readwrite, strong, nonatomic) NSOutputStream* outputStream;
@property (readwrite, strong, nonatomic) NSURL* fileURL;
@property (readwrite, strong, nonatomic) NSURL* outputURL;
@end

@implementation FLFileSink

@synthesize outputStream = _outputStream;
@synthesize fileURL = _fileURL;
@synthesize outputURL = _outputURL;
@synthesize open = _open;

- (id) initWithFileURL:(NSURL*) fileURL {
    self = [super init];
    if(self) {
        self.outputURL = fileURL;
    }
    return self;
}

+ (id) fileSink:(NSURL*) fileURL {
    return FLAutorelease([[[self class] alloc] initWithFileURL:fileURL]);
}

- (void) openSink {
    FLAssert(self.outputStream == nil);
    _open = YES;
    self.fileURL = nil;
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    
    FLAssertNotNil(self.outputURL);
    FLAssert(_open);

    // don't create the file until we actually get bytes. This prevents
    // an empty file on error or redirect or whatever.
    if(!self.outputStream) {
        self.outputStream = [NSOutputStream outputStreamWithURL:self.outputURL append:NO];
        [self.outputStream open];
        
        FLThrowIfError(self.outputStream.streamError);
    }

    NSInteger amountWritten = [self.outputStream write:bytes maxLength:length];
    FLAssert(amountWritten == length);
}

- (void) deleteFile {
    NSError* fileError = nil;
    [[NSFileManager defaultManager] removeItemAtURL:self.outputURL error:&fileError];
}

- (void) closeSinkWithCommit:(BOOL) commit {

    [self.outputStream close];
    self.outputStream = nil;
    _open = NO;
    
    if(commit) {
        self.fileURL = self.outputURL;
    }
    else {
        self.fileURL = nil;
    
        [self deleteFile];
// todo: do what with error?

//        return FLAutorelease(fileError);
    }
}

- (void) dealloc {

    if(_outputStream) {
        [_outputStream close];
        [self deleteFile];
    }

#if FL_MRC
    [_fileURL release];
    [_outputURL release];
    [_outputStream release];
    [super dealloc];
#endif
}


- (NSData*) data {
    
    FLConfirmationFailureWithComment(@"Can't get data from a fileSink");
    
//    FLConfirmWithComment(_outputStream == nil, @"can't get data from an open receiver");
//    
//    NSError* error = nil;
//    NSData* data = [NSData dataWithContentsOfURL:self.fileURL options:nil error:&error];
//    FLThrowIfError(error);
//    
//    return data;
    return nil;
}


@end