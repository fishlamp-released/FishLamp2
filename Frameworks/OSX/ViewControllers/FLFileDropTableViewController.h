//
//  FLFileDropTableViewController.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"

@interface FLFileDropTableViewController : NSViewController {
@private
    IBOutlet NSTableView* _tableView;
    
    NSMutableArray* _urls;
}

@property (readonly, assign, nonatomic) NSTableView* tableView;
@property (readonly, strong, nonatomic) NSArray* utis;
@property (readonly, strong, nonatomic) NSArray* urls;

- (void) addURL:(NSURL*) url;
- (NSURL*) urlForRow:(NSUInteger) row;
- (void) receiveDroppedURL:(NSURL*) url;

+ (NSArray*) imageUTIs;

@end
