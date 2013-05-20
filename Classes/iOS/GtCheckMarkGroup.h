//
//	GtCheckMarkGroup.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCheckMarkTableViewCell.h"

@interface GtCheckMarkGroup : NSObject<GtCheckMarkTableCellDelegate> {
@private
	NSMutableArray* m_rows;
	id m_dataKey;
}

- (id) initWithDataKeyPath:(NSString*) dataKeyPath;
+ (GtCheckMarkGroup*) checkMarkTableCellGroup:(NSString*) dataKeyPath;

@property (readonly, retain, nonatomic) id dataKeyPath;
@property (readwrite, assign, nonatomic) NSUInteger selectedCellIndex;

- (GtCheckMarkTableViewCell*) addRowWithTitle:(NSString*) title value:(id) value isChecked:(BOOL) isChecked;

- (GtCheckMarkTableViewCell*) cellAtIndex:(NSUInteger) idx;
- (NSUInteger) indexForCell:(GtCheckMarkTableViewCell*) cell;

@end
