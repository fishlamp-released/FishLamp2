//
//  FLUploadHistoryViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTableViewController.h"
#import "FLAssetQueue.h"

@interface FLUploadHistoryViewController : FLTableViewController {
@private
	FLObjectDatabase* _database;
	FLAssetQueue* _assetQueue;
	NSMutableArray* _uploadedAssets;
	dispatch_block_t _doneBlock;
}

- (id) initWithAssetQueue:(FLAssetQueue*) queue 
	inDatabase:(FLObjectDatabase*) database 
	doneBlock:(dispatch_block_t) doneBlock;

+ (FLUploadHistoryViewController*) uploadHistoryViewController:(FLAssetQueue*) queue inDatabase:(FLObjectDatabase*) database doneBlock:(dispatch_block_t) doneBlock;
	
@end
