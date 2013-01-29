//
//  FLZfBatchPhotoDownloadOperation.m
//  ZenfolioDownloader
//
//  Created by patrick machielse on 20-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLZfBatchPhotoDownloadOperation.h"
#import "FLZfUtilities.h"
#import "FLAction.h"
#import "FLZfDownloadImageHttpRequest.h"
#import "FLZfDownloaderSession.h"
#import "FLZfUtils.h"

@interface FLZfBatchPhotoDownloadOperation()

- (FLStorableImage*) cachedOriginalImageForPhoto:(FLZfPhoto *)photo;

- (void)setCacheDataPath:(NSString *)path forPhoto:(FLZfPhoto *)photo;

@property (readwrite, strong, nonatomic) NSMutableDictionary* photoCache;
@property (readwrite, assign, getter=isPaused) BOOL paused;
@property (readwrite, strong) FLZfPhotoSet* currentSet;
@property (readwrite, strong) FLZfPhoto* currentPhoto;

@property (readwrite, strong) NSString* destination;
@property (readwrite, strong) NSDate* startDate;
@property (readwrite, assign) NSTimeInterval loadTime;

@property (readwrite, strong) FLZfGroup* rootGroup;

@property (readwrite, assign) int totalPhotoCount;
@property (readwrite, assign) int totalSetCount;
@property (readwrite, assign) long long totalBytes;
@property (readwrite, assign) long long bytesDownloaded;
@property (readwrite, assign) int photosDownloaded;
@end



@implementation FLZfBatchPhotoDownloadOperation

@synthesize currentSet = _currentSet;
@synthesize currentPhoto = _currentPhoto;
@synthesize photoCache = _photoCache;
@synthesize paused = _paused;
@synthesize totalBytes = _totalBytes;
@synthesize bytesDownloaded = _bytesDownloaded;
@synthesize photosDownloaded = _photosDownloaded;
@synthesize totalSetCount = _totalSetCount;
@synthesize loadTime = _loadTime;
@synthesize destination = _destination;
@synthesize rootGroup = _rootGroup;
@synthesize startDate = _startDate;
@synthesize totalPhotoCount = _totalPhotoCount;
@synthesize selection = _selection;
//@synthesize userLogin = _userLogin;

- (id) initWithRootGroup:(FLZfGroup*) rootGroup   destination:(NSString*) destination {
	self = [super init];
    if(self){
        _photoCache = [[NSMutableDictionary alloc] init];
    
        self.rootGroup = rootGroup;
        self.destination = destination;
    }
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_selection release];
    [_currentSet release];
    [_currentPhoto release];
    [_photoCache release];
    [_rootGroup release];
    [_destination release];
    [_photoCache release];
    [_uniquePaths release];
    [_startDate release];
    [super dealloc];
}
#endif


+ (id) photoLoader:(FLZfGroup*) rootGroup  destination:(NSString*) destination {
	return FLAutorelease([[[self class] alloc] initWithRootGroup:rootGroup destination:destination]);
}

- (void)pauseDownload {
    self.paused = YES;
    [self requestCancel];
    
// FIXME        
//	[[self loader] cancel];
}


- (FLStorableImage*) cachedOriginalImageForPhoto:(FLZfPhoto *)photo {
	
    NSString *path = [_photoCache objectForKey:photo.Id];
	return path ? [FLStorableImage imageWithData:[NSData dataWithContentsOfFile:path]] : nil;
}

- (void)setCacheDataPath:(NSString *)path forPhoto:(FLZfPhoto *)photo {
	[[self photoCache] setObject:path forKey:photo.Id];	
}

- (id) init {
    self = [super init];
    if(self) {
    	[self setPhotoCache:[NSMutableDictionary dictionary]];
        _uniquePaths = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) createFolderIfNeeded:(NSString*) path {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    FLThrowError(error);
    [[NSWorkspace sharedWorkspace] noteFileSystemChanged:path];
}

- (NSString*)uniquePathForEntry:(FLZfGroupElement *)entry 
                       inFolder:(NSString*)folder {

    NSString *unique = [_uniquePaths objectForKey:entry.Id];
    if(!unique) {
        unique = FLZfUniquePath([folder stringByAppendingPathComponent:[entry Title]]);
        [_uniquePaths setObject:unique forKey:entry.Id];
    }
    
    return unique;
}

- (void) notifyDownloadedPhoto:(FLZfPhoto*) photo {
    int speed = (int)((self.bytesDownloaded / 1024) / self.loadTime);
    [[NSUserDefaults standardUserDefaults] setInteger:speed forKey:FLZfDownloadSpeed];
//    [self postObservation:@selector(batchPhotoDownloader:didDownloadPhoto:) withObject:photo];
}

- (void)downloadPhoto:(FLZfPhoto *)photo toFolder:(NSString *)folder {
	if ( ![[photo Owner] isEqualToString:[self.context userLogin].userName]) { //     [[NSApp delegate] loginName]] ) 
        return;	//	photo must be from logged-in user
	}
	
    @try {
        FLStorableImage* image = [self cachedOriginalImageForPhoto:photo];
        
        //	download photo from the server if not cached
        if ( !image ) {
            self.currentPhoto = photo;
    
            //	create the url request
            NSTimeInterval startTimestamp = [NSDate timeIntervalSinceReferenceDate];

            FLZfDownloadImageHttpRequest* downloader = [FLZfDownloadImageHttpRequest downloadImageOperation:photo imageSize:[FLZfImageSize originalImageSize]];
            image = FLThrowError([downloader sendSynchronouslyInContext:self.context]);
            
            //	photo was loaded; save the photo to file
            image.imageProperties.fileName = FLZfUniquePath([folder stringByAppendingPathComponent:[photo FileName]]);
            
            if ( [image.imageData writeToFile:image.imageProperties.fileName atomically:YES] ) {
                [self setCacheDataPath: image.imageProperties.fileName  forPhoto:photo];
            } else {
                NSLog(@"could not save photo to \'%@\'", image.imageProperties.fileName);
            }

            _bytesDownloaded +=  [image.imageData length];
            _photosDownloaded++ ;
            
            	//	register loading time
            self.loadTime += ([NSDate timeIntervalSinceReferenceDate] - startTimestamp);

            [self performSelectorOnMainThread:@selector(notifyDownloadedPhoto:) withObject:photo waitUntilDone:YES];
        }
    }
    @finally {
        self.currentPhoto = nil;
    }
    
}

- (void)downloadEntry:(id)entry 
             toFolder:(NSString *)folder {
             
	if ( [entry isGroupElement] ) {
		
        //	check if this group contains photos
		if ( [entry selectedPhotoCount:self.selection] == 0 ) {
			return;
		}
		
        NSString* uniquePath = [self uniquePathForEntry:entry inFolder:folder];
        [self createFolderIfNeeded:uniquePath];
        
        for(FLZfGroupElement* subEntry in [entry Elements]) {
       		[self abortIfNeeded];
            [self downloadEntry:subEntry toFolder:uniquePath];
	    }
    } 
    else if ( [entry isSelected] ) {
        @try {
            self.currentSet = entry;
            
            //	check if this PhotoSet contains photos
            if ( [entry PhotoCount] == 0 ) {
                return;
            }
            
            NSString* uniquePath = [self uniquePathForEntry:entry inFolder:folder];
            [self createFolderIfNeeded:uniquePath];
            
            //	download the photo's
            for (FLZfPhoto* photo in [entry Photos]) {
                [self abortIfNeeded];
                [self downloadPhoto:photo toFolder:uniquePath];
            }
            
            _totalSetCount++;
		}
        @finally {
            self.currentSet = nil;
        }
	}
}

- (FLResult) runOperation {
    self.paused = NO;

    _totalBytes = [self.rootGroup selectedPhotoBytes:self.selection];
    _totalSetCount = [self.rootGroup selectedPhotoSets:self.selection].count;
    _totalPhotoCount = [self.rootGroup selectedPhotoBytes:self.selection];

    @try {
        [[self.context rootGroup] visitAllElements:^(FLZfGroupElement* element, BOOL* stop) {
            [self downloadEntry:element toFolder:[self destination]];
        }];
    }
    @catch(NSException* ex) {
        if(self.paused) {
            return FLSuccessfullResult;
        }
        else {
            @throw;
        }
    }
}

@end
