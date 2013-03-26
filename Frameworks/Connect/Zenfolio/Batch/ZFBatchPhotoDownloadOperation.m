//
//  ZFBatchPhotoDownloadOperation.m
//  ZenfolioDownloader
//
//  Created by patrick machielse on 20-8-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

//#import "FishLampCocoa.h"
//#import "ZFWebApi.h"
//#import "ZFBatchPhotoDownloadOperation.h"
//#import "FLAction.h"
//#import "ZFDownloadImageHttpRequest.h"
//
//@interface ZFBatchPhotoDownloadOperation()
//
//- (FLStorableImage*) cachedOriginalImageForPhoto:(ZFPhoto *)photo;
//
//- (void)setCacheDataPath:(NSString *)path forPhoto:(ZFPhoto *)photo;
//
//@property (readwrite, strong, nonatomic) NSMutableDictionary* photoCache;
//@property (readwrite, assign, getter=isPaused) BOOL paused;
//@property (readwrite, strong) ZFPhotoSet* currentSet;
//@property (readwrite, strong) ZFPhoto* currentPhoto;
//
//@property (readwrite, strong) NSString* destination;
//@property (readwrite, strong) NSDate* startDate;
//@property (readwrite, assign) NSTimeInterval loadTime;
//
//@property (readwrite, strong) ZFGroup* rootGroup;
//
//@property (readwrite, assign) int totalPhotoCount;
//@property (readwrite, assign) int totalSetCount;
//@property (readwrite, assign) long long totalBytes;
//@property (readwrite, assign) long long bytesDownloaded;
//@property (readwrite, assign) int photosDownloaded;
//@end
//
//@implementation ZFBatchPhotoDownloadOperation
//
//@synthesize currentSet = _currentSet;
//@synthesize currentPhoto = _currentPhoto;
//@synthesize photoCache = _photoCache;
//@synthesize paused = _paused;
//@synthesize totalBytes = _totalBytes;
//@synthesize bytesDownloaded = _bytesDownloaded;
//@synthesize photosDownloaded = _photosDownloaded;
//@synthesize totalSetCount = _totalSetCount;
//@synthesize loadTime = _loadTime;
//@synthesize destination = _destination;
//@synthesize rootGroup = _rootGroup;
//@synthesize startDate = _startDate;
//@synthesize totalPhotoCount = _totalPhotoCount;
//@synthesize selection = _selection;
//
////@synthesize userLogin = _userLogin;
//
//- (id) initWithRootGroup:(ZFGroup*) rootGroup   destination:(NSString*) destination {
//	self = [super init];
//    if(self){
//        _photoCache = [[NSMutableDictionary alloc] init];
//    
//        self.rootGroup = rootGroup;
//        self.destination = destination;
//    }
//	return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_selection release];
//    [_currentSet release];
//    [_currentPhoto release];
//    [_photoCache release];
//    [_rootGroup release];
//    [_destination release];
//    [_photoCache release];
//    [_uniquePaths release];
//    [_startDate release];
//    [super dealloc];
//}
//#endif
//
//
//+ (id) photoLoader:(ZFGroup*) rootGroup  destination:(NSString*) destination {
//	return FLAutorelease([[[self class] alloc] initWithRootGroup:rootGroup destination:destination]);
//}
//
//- (void)pauseDownload {
//    self.paused = YES;
//    [self requestCancel];
//    
//// FIXME        
////	[[self loader] cancel];
//}
//
//
//- (FLStorableImage*) cachedOriginalImageForPhoto:(ZFPhoto *)photo {
//	
//    NSString *path = [_photoCache objectForKey:photo.Id];
//	return path ? [FLStorableImage imageWithData:[NSData dataWithContentsOfFile:path]] : nil;
//}
//
//- (void)setCacheDataPath:(NSString *)path forPhoto:(ZFPhoto *)photo {
//	[[self photoCache] setObject:path forKey:photo.Id];	
//}
//
//- (id) init {
//    self = [super init];
//    if(self) {
//    	[self setPhotoCache:[NSMutableDictionary dictionary]];
//        _uniquePaths = [[NSMutableDictionary alloc] init];
//    }
//    return self;
//}
//
//- (void) createFolderIfNeeded:(NSString*) path {
//    NSError* error = nil;
//    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
//    FLThrowIfError(error);
//#if OSX
//    [[NSWorkspace sharedWorkspace] noteFileSystemChanged:path];
//#endif    
//}
//
//- (NSString*)uniquePathForEntry:(ZFGroupElement *)entry 
//                       inFolder:(NSString*)folder {
//
//    NSString *unique = [_uniquePaths objectForKey:entry.Id];
//    if(!unique) {
//        unique = ZFUniquePath([folder stringByAppendingPathComponent:[entry Title]]);
//        [_uniquePaths setObject:unique forKey:entry.Id];
//    }
//    
//    return unique;
//}
//
//- (void) notifyDownloadedPhoto:(ZFPhoto*) photo {
////    int speed = (int)((self.bytesDownloaded / 1024) / self.loadTime);
//
//
////    [[NSUserDefaults standardUserDefaults] setInteger:speed forKey:ZFDownloadSpeed];
////    [self sendMessage:@"batchPhotoDownloader:didDownloadPhoto:" withObject:photo];
//}
//
//- (void)downloadPhoto:(ZFPhoto *)photo toFolder:(NSString *)folder inContext:(id) context {
//	
//    if ( ![[photo Owner] isEqualToString:[context userLogin].userName]) { //     [[NSApp delegate] loginName]] ) 
//        return;	//	photo must be from logged-in user
//	}
//	
//    @try {
//        FLStorableImage* image = [self cachedOriginalImageForPhoto:photo];
//        
//        //	download photo from the server if not cached
//        if ( !image ) {
//            self.currentPhoto = photo;
//    
//            //	create the url request
//            NSTimeInterval startTimestamp = [NSDate timeIntervalSinceReferenceDate];
//
//            ZFDownloadImageHttpRequest* downloader = [ZFDownloadImageHttpRequest downloadImageHttpRequest:photo imageSize:[ZFMediaType originalImageSize] cache:nil];
//  
//            image = [context runWorker:downloader withObserver:nil];
//                                
////            image = FLThrowIfError([self sendHttpRequest:downloader]);
////            [downloader sendSynchronouslyInContext:self.userContext]);
//            
//            //	photo was loaded; save the photo to file
//            image.imageProperties.fileName = ZFUniquePath([folder stringByAppendingPathComponent:[photo FileName]]);
//            
//            if ( [image.imageData writeToFile:image.imageProperties.fileName atomically:YES] ) {
//                [self setCacheDataPath: image.imageProperties.fileName  forPhoto:photo];
//            } else {
//                NSLog(@"could not save photo to \'%@\'", image.imageProperties.fileName);
//            }
//
//            _bytesDownloaded +=  [image.imageData length];
//            _photosDownloaded++ ;
//            
//            	//	register loading time
//            self.loadTime += ([NSDate timeIntervalSinceReferenceDate] - startTimestamp);
//
//            [self performSelectorOnMainThread:@selector(notifyDownloadedPhoto:) withObject:photo waitUntilDone:YES];
//        }
//    }
//    @finally {
//        self.currentPhoto = nil;
//    }
//    
//}
//
//- (void)downloadEntry:(id)entry 
//             toFolder:(NSString *)folder
//            inContext:(id) context {
//             
////	if ( [entry isGroupElement] ) {
////		
////        //	check if this group contains photos
////		if ( [entry selectedPhotoCountInSelection:self.selection] == 0 ) {
////			return;
////		}
////		
////        NSString* uniquePath = [self uniquePathForEntry:entry inFolder:folder];
////        [self createFolderIfNeeded:uniquePath];
////        
////        for(ZFGroupElement* subEntry in [entry Elements]) {
////       		[self abortIfNeeded];
////            [self downloadEntry:subEntry toFolder:uniquePath];
////	    }
////    } 
////    else if ( [entry isSelected] ) {
////        @try {
////            self.currentSet = entry;
////            
////            //	check if this PhotoSet contains photos
////            if ( [entry PhotoCount] == 0 ) {
////                return;
////            }
////            
////            NSString* uniquePath = [self uniquePathForEntry:entry inFolder:folder];
////            [self createFolderIfNeeded:uniquePath];
////            
////            //	download the photo's
////            for (ZFPhoto* photo in [entry Photos]) {
////                [self abortIfNeeded];
////                [self downloadPhoto:photo toFolder:uniquePath];
////            }
////            
////            _totalSetCount++;
////		}
////        @finally {
////            self.currentSet = nil;
////        }
////	}
//}
//
//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//    self.paused = NO;
//
////    _totalBytes = [self.rootGroup selectedPhotoBytesInSelection:self.selection];
////    _totalSetCount = [self.rootGroup photoSetsInSelection:self.selection].count;
////    _totalPhotoCount = [self.rootGroup selectedPhotoBytesInSelection:self.selection];
//
//    @try {
//        [[context rootGroup] visitAllSubElements:^(ZFGroupElement* element, BOOL* stop) {
//            [self downloadEntry:element toFolder:[self destination] inContext:context];
//        }];
//    }
//    @catch(NSException* ex) {
//        if(self.paused) {
//            return FLSuccessfullResult;
//        }
//        else {
//            @throw;
//        }
//    }
//}
//
//@end
