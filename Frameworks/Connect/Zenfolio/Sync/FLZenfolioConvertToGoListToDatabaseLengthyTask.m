//
//  FLZenfolioConvertToGoListToDatabaseLengthyTask.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioConvertToGoListToDatabaseLengthyTask.h"
#import "FLZenfolioSyncService.h"
#import "FLUserDataStorageService.h"

//#import "FLZenfolioStorageService.h"

#define kFileName @"ToGo.plist"

@implementation FLZenfolioConvertToGoListToDatabaseLengthyTask

- (void) executeSelf
{
	self.taskName = NSLocalizedString(@"Updating To-Go List", nil);
	
	@synchronized([self.context syncService]) {
		if([[[self.context userStorageService] documentsFolder] fileExistsInFolder:kFileName])
		{
			NSDictionary* file = [[[self.context userStorageService] documentsFolder] readObjectFromFile:kFileName];
			
			NSMutableArray* items = [NSMutableArray array];
			for(FLZenfolioGroupElementSyncInfo* info in file.objectEnumerator)
			{
				if(info.syncObjectIdValue)
				{
					[items addObject:info];
				}
			}

			[[[self.context userStorageService] documentsDatabase] batchSaveObjects:items];

			NSString* filePath = [[[self.context userStorageService] documentsFolder] pathForFile:kFileName];
			
			[[NSFileManager defaultManager] moveItemAtPath:filePath 
				toPath:[NSString stringWithFormat:@"%@_old", filePath] 
				error:nil];
		}
	}
}

@end