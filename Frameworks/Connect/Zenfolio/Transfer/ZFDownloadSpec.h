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
    NSString* _destinationPath;
    ZFPhoto* _photo;
    ZFMediaType* _mediaType;
    NSString* _downloadFolderPath;
    NSString* _fileName;
}
@property (readwrite, assign, nonatomic) NSInteger rootGroupID;
@property (readwrite, assign, nonatomic) NSInteger photoSetID;
@property (readwrite, strong, nonatomic) NSString* destinationPath;
@property (readwrite, strong, nonatomic) NSString* hiddenFolderPath;
@property (readwrite, strong, nonatomic) ZFPhoto* photo;
@property (readwrite, strong, nonatomic) ZFMediaType* mediaType;
@property (readwrite, strong, nonatomic) NSString* fileName;

- (id) initWithPhoto:(ZFPhoto*) photo;
+ (id) downloadSpec:(ZFPhoto*) photo;

@end
