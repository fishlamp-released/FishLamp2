//
//	FLCheckMarkGroup.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLCheckMarkTableViewCell.h"

@interface FLCheckMarkGroup : NSObject<FLCheckMarkTableCellDelegate> {
@private
	NSMutableArray* _rows;
	id _dataKey;
}

- (id) initWithDataKeyPath:(NSString*) dataKeyPath;
+ (FLCheckMarkGroup*) checkMarkTableCellGroup:(NSString*) dataKeyPath;

@property (readonly, retain, nonatomic) id dataKeyPath;
@property (readwrite, assign, nonatomic) NSUInteger selectedCellIndex;

- (FLCheckMarkTableViewCell*) addRowWithTitle:(NSString*) title value:(id) value isChecked:(BOOL) isChecked;

- (FLCheckMarkTableViewCell*) cellAtIndex:(NSUInteger) idx;
- (NSUInteger) indexForCell:(FLCheckMarkTableViewCell*) cell;

@end
