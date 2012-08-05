//
//  FLTextGridViewCell.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/20/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewCell.h"

@interface FLGridViewTextCell : FLGridViewCell {
@private
    NSString* _text;
    UILabel* _label;
}
@property (readwrite, retain, nonatomic) NSString* text;
@end

