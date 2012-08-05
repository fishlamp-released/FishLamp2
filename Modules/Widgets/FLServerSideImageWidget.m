//
//  FLServerSideImageWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLServerSideImageWidget.h"
#import "FLActionContextManager.h"
#import "FLDownloadImageOperation.h"
#import "FLAction.h"

@implementation FLServerSideImageWidget

- (void) setImageURL:(NSString*) url
{
	FLAssignObject(_url, url);

    FLAction* action = [FLAction action];
    [action actionDescription].actionType = FLActionDescriptionTypeDownload;
    [action actionDescription].actionItemName = NSLocalizedString(@"Profile Photo", nil);
    [action queueOperation:[FLDownloadImageOperation networkOperationWithURLString:url]];
    
    action.onFinished = ^(id theAction) {
        if([theAction didFinishWithoutError])
        {
            self.foregroundThumbnail =
                [[theAction lastOperation] imageOutput];
        } 
    };

	[[FLActionContextManager instance].activeContext beginAction:action];
}

@end
