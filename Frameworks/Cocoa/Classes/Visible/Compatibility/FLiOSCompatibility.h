//
//  FLiOSCompatibility.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#if IOS
#define NSView_                     UIView
#define UIView_                     UIView

#define NSViewController_           UIViewController
#deifne UIViewController_           UIViewController

#define NSImage_                    UIImage
#define UIImage_                    UIImage

#define NSColor_                    UIColor_
#define UIColor_                    UIColor_

#endif