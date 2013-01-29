//
//  ZFDownloaderSession.m
//  Downloader
//
//  Created by Mike Fullerton on 11/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFDownloaderSession.h"
#import "ZFSoapHttpRequestFactory.h"
#import "FLDispatchQueue.h"
#import "ZFUtilities.h"
#import "ZFSyncGroupHierarchyOperation.h"
#import "ZFBatchPhotoDownloadOperation.h"
#import "ZFSyncGroupHierarchyOperation.h"


NSString * const ZFBaseFolder		= @"BaseFolder";
NSString * const ZFDownloadSpeed	= @"DownloadSpeed";


@implementation ZFDownloaderSession

@synthesize destination = _destination;
@synthesize imageDownloader = _imageDownloader;
@synthesize selection = _selection;

- (id) init {
    self = [super init];
    if(self) {
        _selection = [[ZFGroupElementSelection alloc] init];
        FLCreateAndRegisterService(imageDownloader, ZFImageDownloadingService);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_selection release];
    [_imageDownloader release];
    [_destination release];
    [super dealloc];
}
#endif

- (NSString*) baseFolder {
    return [[NSUserDefaults standardUserDefaults] objectForKey:ZFBaseFolder];
}


//- (void) setLoadedAllGalleriesForGroup:(ZFGroup*) group {
//    self.rootGroup = group;
//
//    //	//	show hierarchy
//}

- (NSString *)downloadFolder {
	return [self.baseFolder stringByAppendingPathComponent:[self downloadFolderName]];
}

- (NSString *)downloadFolderName {
	NSString *fmt  = @"Zenfolio Download %1m-%e-%Y";
	NSString *name = [[NSCalendarDate date] descriptionWithCalendarFormat:fmt];
	NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:ZFBaseFolder];
	if ( !path ) {
		return name;
	}
	
	path = [path stringByAppendingPathComponent:name];
	return [ZFUniquePath(path) lastPathComponent];
}



- (FLFinisher*) startSyncingGroupList:(FLResultBlock) completionBlock {
    
    self.rootGroup = nil;
    
    ZFSyncGroupHierarchyOperation* operation = [ZFSyncGroupHierarchyOperation syncGroupHierarchyOperation:self.userLogin];

    completionBlock = FLCopyWithAutorelease(completionBlock);

    return [FLDefaultDispatcher dispatchObject:operation 
                        completion:^(FLResult result) {

        FLAssert_([NSThread isMainThread]);
        if([result succeeded]) {
            self.rootGroup = result;
        }
        
        if(completionBlock) {
            completionBlock(result);
        }
    }];

}

- (FLFinisher*) resumeDownload:(ZFBatchPhotoDownloadOperation*) downloader 
                    completion:(FLResultBlock) completionBlock {
    
    completionBlock = FLCopyWithAutorelease(completionBlock);
    
    return [FLDefaultDispatcher dispatchObject:downloader 
                               completion:^(FLResult result) {

//        [self postObservation:@selector(downloaderUserContext:downloadFinished:withError:) withObject:downloader withObject:[result error]];

        if(completionBlock) {
            completionBlock(result);
        }
    }];
}

- (FLFinisher*) startDownload:(FLResultBlock) completionBlock {
    ZFBatchPhotoDownloadOperation* loader = [ZFBatchPhotoDownloadOperation photoLoader:self.rootGroup destination:self.downloadFolder];
    
//    [self postObservation:@selector(downloaderUserContext:downloadStarted:) withObject:loader];
        
    return [self resumeDownload:loader completion:completionBlock];
}


//@synthesize loading = _loading;
//- (NSArray *)selectedPhotoSets {
//	return [_session.rootGroup selectedPhotoSets];
//}
//- (BOOL) canStart {
//    return self.selectionSize > 0;
//}
//
//- (int) totalSets {
//    return _session.rootGroup.selectedPhotoSets.count;
//}
//
//- (NSString *)downloadSizeText {
//	return ZFSizeString(self.selectionSize);
//}
//
//- (NSString *)downloadTimeText {
//	return ZFTimeString([self.download loadTime]);
//}
//
//- (NSString*) destination {
//    return _session.destination;
//}
//
//- (NSString*) loginName {
//    return _session.userLogin.userName;
//}
//
//- (NSString*) baseFolder {
//    return _session.baseFolder;
//}
//
//- (NSString *)downloadFolder {
//	return _session.downloadFolder; 
//}
//
//- (NSString *)downloadFolderName {
//	return _session.downloadFolderName; 
//}

//- (int)selectedSetCount {
//	return [[self selectedPhotoSets] count];
//}

////	returns the total number of photos in the selected photosets
//- (int)selectedPhotoCount {
//	return [_session.rootGroup selectedPhotoCount];
//}
//
////	returns the sum of the photobytes in the selected photosets
//- (long long)selectionSize {
//    return _session.rootGroup.selectedPhotoBytes;
//}
//
//- (NSString *)selectionSizeText {
//	return ZFSizeString([self selectionSize]);
//}


//- (void) setLoadedRootGroup:(ZFGroup*) rootGroup {
//
//    [[FLActionQueue instance] dispatchWorker:[_session.httpRequestFactory loadPhotoSetsForGroupOperation:rootGroup]
//                              completion:^(FLResult result) {
//        if(![result succeeded]) {
//
//        // TODO: report error?? 
//
//            return ; 
//        }
//        
//        [self setLoadedAllGalleriesForGroup:rootGroup];
//    }];
//}

//- (void) startDownload
//{
//    if(_session.photoLoader.isLoading) {
//        if ( [_session.photoLoader isPaused] ) {
//            [_session.photoLoader resumeDownload];
//        } 
//        else {
//            [_session.photoLoader pauseDownload];
//        } 
//    }
//    else {
//		//	create download folder
//		NSString *downloadFolder = [self downloadFolder];
//		
//        NSError* error = nil;
//
//        NSURL* folderURL = [NSURL fileURLWithPath:downloadFolder isDirectory:YES];
//
//        [[NSFileManager defaultManager] createDirectoryAtPath:[folderURL absoluteString] withIntermediateDirectories:YES attributes:nil error:&error];
//
//		[[NSWorkspace sharedWorkspace] noteFileSystemChanged:downloadFolder];
//		
//		[_session.photoLoader downloadAccountToFolder:downloadFolder];
//	}
//}


//- (IBAction)loadGroupHierarchy:(id)sender
//{
////	//	show loading... message
////	[self willChangeValueForKey:@"selectedPhotoSets"];
////    [self didChangeValueForKey:@"selectedPhotoSets"];
//	
//    _session.rootGroup = nil;
//    
//    FLAssertNotNil_(_session);
//    FLAssertNotNil_(_session.httpRequestFactory);
//    
//    [[FLActionQueue instance] dispatchWorker:[_session.httpRequestFactory loadGroupHierarchyOperation]
//                                  completion:^(FLResult result) {
//        
//        if(![result succeeded]) {
//        
//            // TODO: report error?? 
//            return ; 
//        }
//        
//        [self setLoadedRootGroup:result.output];
//    }];
//}

//- (void)setPhotoLoader:(ZFBatchPhotoDownloadOperation *)newPhotoLoader {
//    if(_session.photoLoader) {
//        [self removeService:_session.photoLoader];
//    }
//}

@end
