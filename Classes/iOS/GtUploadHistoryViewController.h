//
//  GtUploadHistoryViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTableViewController.h"
#import "GtAssetQueue.h"

@interface GtUploadHistoryViewController : GtTableViewController {
@private
	GtObjectDatabase* m_database;
	GtAssetQueue* m_assetQueue;
	NSMutableArray* m_uploadedAssets;
	GtBlock m_doneBlock;
}

- (id) initWithAssetQueue:(GtAssetQueue*) queue 
	inDatabase:(GtObjectDatabase*) database 
	doneBlock:(GtBlock) doneBlock;

+ (GtUploadHistoryViewController*) uploadHistoryViewController:(GtAssetQueue*) queue inDatabase:(GtObjectDatabase*) database doneBlock:(GtBlock) doneBlock;
	
@end
