//
//	FLHtmlHelpViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLWebViewController.h"

#import "FLGradientView.h"

@interface FLHtmlHelpViewController : FLWebViewController {
@private
	FLGradientView* _gradientView;
	NSString* _fileName;
    NSURL* _fileURL;
}

@property (readwrite, retain, nonatomic) NSString* fileName;

@end
