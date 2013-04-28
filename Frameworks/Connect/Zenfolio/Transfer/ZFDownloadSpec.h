//
//  ZFDownloadSpec.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFDownloadSpec : NSObject {
@private
    NSInteger _photoSetID;
    NSInteger _rootGroupID;
    NSString* _fullPathToFile;
    ZFPhoto* _photo;
    ZFMediaType* _mediaType;
    NSString* _tempFolder;
    NSString* _relativePath;
    
    BOOL _wasSkipped;
    BOOL _wasDownloaded;
}
@property (readwrite, assign, nonatomic) NSInteger rootGroupID;
@property (readwrite, assign, nonatomic) NSInteger photoSetID;
@property (readwrite, strong, nonatomic) NSString* fullPathToFile;
@property (readwrite, strong, nonatomic) NSString* tempFolder;
@property (readwrite, strong, nonatomic) ZFPhoto* photo;
@property (readwrite, strong, nonatomic) ZFMediaType* mediaType;
@property (readwrite, strong, nonatomic) NSString* relativePath;

@property (readwrite, assign, nonatomic) BOOL wasSkipped;
@property (readwrite, assign, nonatomic) BOOL wasDownloaded;

- (id) initWithPhoto:(ZFPhoto*) photo;
+ (id) downloadSpec:(ZFPhoto*) photo;

@end