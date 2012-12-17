//
//  FLStorable.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "NSObject+Copying.h"

@protocol FLStorable <NSObject, FLCopyable, NSCopying>
@property (readwrite, strong) NSString* storableType; // UTI
@property (readwrite, strong) NSString* storableSubType;
@property (readwrite, strong) id storageKey;
@end

@interface FLStorable : NSObject<FLStorable> {
@private
    id _storageKey;
    NSString* _storableType;
    NSString* _storableSubType;
}

@end