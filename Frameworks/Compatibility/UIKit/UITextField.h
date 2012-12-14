//
//  UITextField.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIKitRequired.h"

#if OSX

#define UITextField NSTextField

@interface NSTextField (UIKit)
@property (readwrite, strong, nonatomic) NSString* text;
@end

#endif