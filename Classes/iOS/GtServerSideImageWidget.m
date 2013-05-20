//
//  GtServerSideImageWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtServerSideImageWidget.h"
#import "GtActionContextManager.h"
#import "GtDownloadImageOperation.h"
#import "GtAction.h"

@implementation GtServerSideImageWidget

- (void) setImageURL:(NSString*) url
{
	GtAssignObject(m_url, url);

	[[GtActionContextManager instance].activeContext beginAction:[GtAction action] configureAction:^(id action) {
		[action actionDescription].actionType = GtActionDescriptionTypeDownload;
		[action actionDescription].itemName = NSLocalizedString(@"Profile Photo", nil);
		[action queueOperation:[GtDownloadImageOperation networkOperationWithURLString:url] configureOperation:^(id operation) {
			}];
		
		[action setDidCompleteCallback:^{
			if([action didFinishWithoutError])
			{
				self.foregroundThumbnail =
					[[action lastOperation] imageOutput];
			}
		}];
	}];
}

@end
