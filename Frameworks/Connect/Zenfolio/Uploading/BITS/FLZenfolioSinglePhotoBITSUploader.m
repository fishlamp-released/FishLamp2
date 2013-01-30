//
//  FLZenfolioSinglePhotoBITSUploader.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#if REFACTOR

#import "FLZenfolioSinglePhotoBITSUploader.h"

#import "FLZenfolioBITSCreateSessionOperation.h"
#import "FLZenfolioBITSCloseSessionOperation.h"
#import "FLZenfolioBITSUploadFragment.h"

#define kBitsFragmentSize (200 * 1024)


@interface FLZenfolioSinglePhotoBITSUploader ()
- (void) _beginUploadingNextFragment;
@end

@implementation FLZenfolioSinglePhotoBITSUploader

@synthesize isClosing = _closing;

- (void) _beginCloseSession
{
    _closing = YES;
    
    FLAction* action = [self createAction];
    [action addOperation:FLAutorelease([[FLZenfolioBITSCloseSessionOperation alloc] initWithUploadablePhoto:self.photo 
        sessionInfo:_sessionInfo
        fileSize:_fileSize]) 
        ];

    [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
            if([action didSucceed])
            {
                self.bytesUploaded = self.uploadSize;
                [self _updateProgress];
            
                [self changeStateToNextState];
            }
            else
            {
               [self _didFinishWithError:[action error]];
            }
            
            FLReleaseWithNil(_sessionInfo);
        }];
}

- (BOOL) _uploadIsDone
{
    return _chunkStart >= (_fileSize-1);
}

- (void) _didUploadFragment:(FLAction*) action
{
    if(action.didSucceed)
    {
        FLZenfolioBITSUploadFragment* uploader = [action lastOperation];
        _chunkStart += uploader.amountWritten;

#if TRACE       
        FLLog(@"Amount written: %qu, New chunk start: %qu, File Size: %qu", uploader.amountWritten, _chunkStart, _fileSize);
#endif        
        
        if([self _uploadIsDone])
        {
            [self _beginCloseSession];
        }
        else
        {
            [self _beginUploadingNextFragment];
        }
    }
    else
    {
        [self _didFinishWithError:action.error];
    }
}

- (void) _updateProgressWhileUploadingImage:(unsigned long long) amountWritten
    totalAmountWritten:(unsigned long long) totalAmountWritten
    totalAmountExpectedToWrite:(unsigned long long) totalAmountExpectedToWrite
{
	self.bytesUploaded = totalAmountWritten;
}

- (BOOL) isBusy
{
    return self.action != nil;
}

- (BOOL) hasExpired
{
    return _startTime != 0.0f && ([NSDate timeIntervalSinceReferenceDate] - _startTime) > kZenfolioSinglePhotoBITSUploaderExpireTime;
}

- (void) _beginUploadingNextFragment {
    FLAssertIsNotNil_(self.photo);
    FLAssertIsNotNil_(self.imageFile);
    
    self.uploadSize = _fileSize + (_fileSize * 0.1);
    self.bytesUploaded = _chunkStart;

    FLAction* action = [self createAction];
    [action addOperation:FLAutorelease([[FLZenfolioBITSUploadFragment alloc] initWithUploadablePhoto:self.photo 
        preparedImage:self.imageFile
        startOffset:_chunkStart
        chunkSize:kBitsFragmentSize
        fileSize:_fileSize
        sessionInfo:_sessionInfo
        ] )];

    action.onUpdateProgress = ^(id theAction,
                                unsigned long long amountWritten,
                                unsigned long long totalAmountWritten,
                                unsigned long long totalAmountExpectedToWrite){
        self.bytesUploaded += amountWritten;
        [self _updateProgress];
        };

	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
        [self _didUploadFragment:action]; 
        }];
}

- (void) _dealloc
{   
    FLRelease(_sessionInfo);
    FLSuperDealloc();
}

- (void) _beginBitsSession
{
    FLAction* action = [self createAction];
 
    [action addOperation:FLAutorelease([[FLZenfolioBITSCreateSessionOperation alloc] initWithUploadablePhoto:self.photo])];
    
    [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
        if([action didSucceed])
        {
            _startTime = [NSDate timeIntervalSinceReferenceDate];
            _fileSize = [self.imageFile sizeInStorage];
            _chunkStart = 0;
            FLSetObjectWithRetain(_sessionInfo, [[action lastOperation] operationOutput]);
            [self _beginUploadingNextFragment];
        }
        else
        {
            [self _didFinishWithError:[action error]];
        }
    }];
}

- (void) _beginUploadingBytes
{
    FLAssert_v([NSThread isMainThread], @"not on main thread");

    FLAssertIsNotNil_(self.photo);
    FLAssertIsNotNil_(self.imageFile);
   
    if(_sessionInfo)
    {
        if([self _uploadIsDone])
        {
            [self _beginCloseSession];
        }
        else
        {
            [self _beginUploadingNextFragment];
        }
    }
    else
    {
        [self _beginBitsSession];
    }
}

@end
#endif