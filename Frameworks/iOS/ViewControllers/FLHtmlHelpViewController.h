//
//	FLHtmlHelpViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/17/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
