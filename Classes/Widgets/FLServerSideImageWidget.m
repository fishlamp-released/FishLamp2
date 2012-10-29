//
//  FLServerSideImageWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLServerSideImageWidget.h"
#import "FLDownloadImageOperation.h"
#import "FLAction.h"

@implementation FLServerSideImageWidget

- (void) startDownloadingImage:(NSString*) url
              inViewController:(UIViewController*) viewController {
	FLAssignObject(_url, url);

    FLAction* action = [FLAction action];
    [action actionDescription].actionType = FLActionDescriptionTypeDownload;
    [action actionDescription].actionItemName = NSLocalizedString(@"Profile Photo", nil);
    [action addOperation:[FLDownloadImageOperation networkOperationWithURLString:url]];

	[viewController startAction:action completion: ^(id<FLResult> result) {
        if([action didSucceed]) {
            self.foregroundThumbnail =
                [[action lastOperation] imageOutput];
        } 
    }];
}

@end
