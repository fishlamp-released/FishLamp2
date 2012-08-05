//
//  FLUploadHistoryViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTableViewController.h"
#import "FLAssetQueue.h"

@interface FLUploadHistoryViewController : FLTableViewController {
@private
	FLObjectDatabase* m_database;
	FLAssetQueue* m_assetQueue;
	NSMutableArray* m_uploadedAssets;
	FLEventCallback m_doneBlock;
}

- (id) initWithAssetQueue:(FLAssetQueue*) queue 
	inDatabase:(FLObjectDatabase*) database 
	doneBlock:(FLEventCallback) doneBlock;

+ (FLUploadHistoryViewController*) uploadHistoryViewController:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(FLEventCallback) doneBlock;
	
@end
