//
//  FLDrawableString.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDrawable.h"
#import "FLAttributedString.h"
#import "FLCoreText.h"

@interface FLDrawableString : FLAttributedString<FLDrawable> {
@private
    FLTextAlignment _textAlignment;
}
@property (readwrite, assign, nonatomic) FLTextAlignment textAlignment;
@end
