//
//  FLHttpRequestContent.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLHttpRequestHeaders.h"

@interface FLHttpRequestContent : NSObject {
@private
    FLHttpRequestHeaders* _httpHeaders;
    NSString* _postBodyFilePath;
    NSData* _postData;
    NSInputStream* _bodyStream;
}

@property (readonly, strong, nonatomic) FLHttpRequestHeaders* httpHeaders;
@property (readwrite, strong, nonatomic) NSData* bodyData;
@property (readwrite, strong, nonatomic) NSInputStream* bodyStream;
@property (readwrite, strong, nonatomic) NSString* postBodyFilePath;

- (void) setFormUrlEncodedContent:(NSString*) content;
 
- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;

- (void) setUtf8Content:(NSString*) content;

// TODO: refactor away from JPEG specific type
- (void) setJpegContentWithData:(NSData*) imageData;

- (void) setJpegContentWithFilePath:(NSString*) filePath;

@end
