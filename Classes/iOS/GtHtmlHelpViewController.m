//
//	GtHtmlHelpViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/17/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHtmlHelpViewController.h"
#import "NSFileManager+GtExtras.h"
#import "GtGradientView.h"

@implementation GtHtmlHelpViewController

@synthesize fileName = m_fileName;

- (id) initWithButtonMode:(GtWebViewControllerButtonMode) buttonMode
{
	if((self = [super initWithButtonMode:buttonMode]))
	{
		self.openHttpLinksInSafari = YES;
        if(buttonMode == GtWebViewControllerButtonModeNone)
        {
            self.openLinksInNewViewController = YES;
        }
        
        [self createActionContext];
    }
	
	return self;
}

- (void) dealloc
{	
    GtRelease(m_fileURL);
	GtRelease(m_fileName);
	GtRelease(m_gradientView);
	GtSuperDealloc();
}

- (BOOL) currentDocumentIsFile
{
	return [self.currentLocationUrl hasPrefix:@"file:"];
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	m_gradientView = [[GtGradientView alloc] initWithFrame:self.view.bounds];
	m_gradientView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	m_gradientView.autoresizesSubviews = YES;
    [self.view insertSubview:m_gradientView belowSubview:self.webView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if(m_fileURL)
    {
        [self beginLoadingURL:m_fileURL];
    }
}

- (NSString*) fullyQualifiedNameForFileName:(NSString*) fileName
{
	if([fileName rangeOfString:@"en-"].length > 0)
	{
		return fileName;
	}

	return DeviceIsPad() ? [NSString stringWithFormat:@"iPad-en-%@", fileName] : [NSString stringWithFormat:@"en-%@", fileName];
}

- (void) setFileName:(NSString*) string
{
    GtReleaseWithNil(m_fileURL);
	GtAssignObject(m_fileName, [self fullyQualifiedNameForFileName:string]);
    
    NSString* basePath = [[NSBundle mainBundle] bundlePath];
	
	NSURL *baseURL = [NSURL fileURLWithPath:basePath isDirectory:YES];

//	if(GtStringIsNotEmpty(anchorNameOrNil))
//	{
//		fileName = [NSString stringWithFormat:@"%@#%@", fileName, anchorNameOrNil];
//	}
	
    GtAssignObject(m_fileURL, [NSURL URLWithString:m_fileName relativeToURL:baseURL]);
	
    if(self.isViewLoaded)
    {
        [self beginLoadingURL:m_fileURL];
    }
}
//
//- (void) beginLoadingFileInBundle:(NSString*) fileName anchor:(NSString*) anchorNameOrNil
//{
//	GtAssertIsValidString(fileName);
//	
//	NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
//	[self.webView loadRequest:request];
//}

@end
