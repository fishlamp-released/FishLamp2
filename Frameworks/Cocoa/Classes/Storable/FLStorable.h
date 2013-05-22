//
//  FLStorable.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import "NSObject+Copying.h"

@protocol FLStorable <NSObject, FLCopyable, NSCopying>
@property (readonly, strong, nonatomic) NSString* storableType; // UTI
@property (readonly, strong, nonatomic) id storageKey;

@property (readwrite, strong, nonatomic) NSString* storableSubType;
@end

@interface FLStorable : NSObject<FLStorable> {
@private
    id _storageKey;
    NSString* _storableType;
    NSString* _storableSubType;
}
@property (readwrite, strong, nonatomic) NSString* storableType; // UTI
@property (readwrite, strong, nonatomic) id storageKey;

@end