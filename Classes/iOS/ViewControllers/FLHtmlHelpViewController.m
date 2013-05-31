//
//	FLHtmlHelpViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/17/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHtmlHelpViewController.h"
#import "NSFileManager+FLExtras.h"
#import "FLGradientView.h"

@implementation FLHtmlHelpViewController

@synthesize fileName = _fileName;

- (id) initWithButtonMode:(FLWebViewControllerButtonMode) buttonMode {
	if((self = [super initWithButtonMode:buttonMode])) {
		self.openHttpLinksInSafari = YES;
        if(buttonMode == FLWebViewControllerButtonModeNone) {
            self.openLinksInNewViewController = YES;
        }
    }
	
	return self;
}

- (void) dealloc {	
    FLRelease(_fileURL);
	FLRelease(_fileName);
	FLRelease(_gradientView);
	FLSuperDealloc();
}

- (BOOL) currentDocumentIsFile {
	return [self.currentLocationUrl hasPrefix:@"file:"];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	
	_gradientView = [[FLGradientView alloc] initWithFrame:self.view.bounds];
	_gradientView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	_gradientView.autoresizesSubviews = YES;
    [self.view insertSubview:_gradientView belowSubview:self.webView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(_fileURL) {
        [self beginLoadingURL:_fileURL];
    }
}

- (NSString*) fullyQualifiedNameForFileName:(NSString*) fileName {
	if([fileName rangeOfString:@"en-"].length > 0) {
		return fileName;
	}

	return DeviceIsPad() ? [NSString stringWithFormat:@"iPad-en-%@", fileName] : [NSString stringWithFormat:@"en-%@", fileName];
}

- (void) setFileName:(NSString*) string {
    FLReleaseWithNil(_fileURL);
	FLSetObjectWithRetain(_fileName, [self fullyQualifiedNameForFileName:string]);
    
    NSString* basePath = [[NSBundle mainBundle] bundlePath];
	
	NSURL *baseURL = [NSURL fileURLWithPath:basePath isDirectory:YES];

//	if(FLStringIsNotEmpty(anchorNameOrNil))
//	{
//		fileName = [NSString stringWithFormat:@"%@#%@", fileName, anchorNameOrNil];
//	}
	
    FLSetObjectWithRetain(_fileURL, [NSURL URLWithString:_fileName relativeToURL:baseURL]);
	
    if(self.isViewLoaded) {
        [self beginLoadingURL:_fileURL];
    }
}
//
//- (void) beginLoadingFileInBundle:(NSString*) fileName anchor:(NSString*) anchorNameOrNil
//{
//	FLAssertStringIsNotEmpty(fileName);
//	
//	NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
//	[self.webView loadRequest:request];
//}

@end
