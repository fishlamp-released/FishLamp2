//
//  FLServerSideImageWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLServerSideImageWidget.h"
#import "FLDownloadImageHttpRequest.h"
#import "FLAction.h"

@implementation FLServerSideImageWidget

- (void) startDownloadingImage:(NSString*) url
              inViewController:(UIViewController*) viewController {
	FLSetObjectWithRetain(_url, url);

    FLAction* action = [FLAction action];
    [action actionDescription].actionType = FLActionDescriptionTypeDownload;
    [action actionDescription].actionItemName = NSLocalizedString(@"Profile Photo", nil);
    [action addOperation:[FLDownloadImageHttpRequest networkOperationWithURLString:url]];

	[viewController startAction:action completion: ^(id result) {
        if([action didSucceed]) {
            self.foregroundThumbnail =
                [[action lastOperation] imageOutput];
        } 
    }];
}

@end
