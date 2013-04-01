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

    self.fileURL = nil;
    self.outputStream = [NSOutputStream outputStreamWithURL:self.outputURL append:NO];
    [self.outputStream open];
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    
    FLAssertNotNil(self.outputURL);

    NSInteger amountWritten = [self.outputStream write:bytes maxLength:length];
    FLAssert(amountWritten == length);
}

- (void) closeSinkWithError:(NSError*) error {

    [self.outputStream close];
    self.outputStream = nil;
    
    if(error) {
        self.fileURL = nil;
    
        NSError* fileError = nil;
        [[NSFileManager defaultManager] removeItemAtURL:self.outputURL error:&fileError];

// todo: do what with error?

//        return FLAutorelease(fileError);
    }
}

- (void) commit {
    self.fileURL = self.outputURL;
}

#if FL_MRC
- (void) dealloc {
    [_fileURL release];
    [_outputURL release];
    [_outputStream release];
    [super dealloc];
}
#endif


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