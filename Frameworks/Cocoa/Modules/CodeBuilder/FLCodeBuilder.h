//
//  FLCodeBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLPrettyString.h"

@interface FLCodeBuilder : FLPrettyString {
@private
    NSString* _openBracket;
    NSString* _closeBracket;
}

+ (id) codeBuilder;

@property (readwrite, strong, nonatomic) NSString* openBracket;
@property (readwrite, strong, nonatomic) NSString* closeBracket;

@end
