//
//  FLTwitterLoginWebViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/30/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterLoginWebViewController.h"

@implementation FLTwitterLoginWebViewController

- (id) initWithButtonMode:(FLWebViewControllerButtonMode)buttonMode
{
    if((self = [super initWithButtonMode:buttonMode]))
    {
        self.autoSetTitle = NO;
        self.title = NSLocalizedString(@"Twitter", nil);
    }
    
    return self;
}

- (BOOL) shouldNavigateToLink:(NSURL *)url
{
    static NSArray* s_strings = nil;
    if(!s_strings)
    {
        s_strings = [[NSArray alloc] initWithObjects:
            // put known links we're okay to navigating to here.
            nil];
    }

    NSString* urlStr = url.absoluteString;
    FLLog(@"check url: %@", urlStr);
        
    for(NSString* partialUrl in s_strings)
    {
        if([urlStr rangeOfString:partialUrl].length)
        {
            return YES;
        }
    }
    [self openURLInSafari:url];
            
    return NO;
}


@end
