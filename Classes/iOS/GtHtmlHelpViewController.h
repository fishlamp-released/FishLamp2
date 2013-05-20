//
//	GtHtmlHelpViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/17/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtWebViewController.h"

#import "GtGradientView.h"

@interface GtHtmlHelpViewController : GtWebViewController {
@private
	GtGradientView* m_gradientView;
	NSString* m_fileName;
    NSURL* m_fileURL;
}

@property (readwrite, retain, nonatomic) NSString* fileName;

@end
