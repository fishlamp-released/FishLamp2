//
//  GtEditPanel.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE




#import "GtDisplayFormatter.h"
#import "GtDisplayDataRow.h"
#import "GtViewController.h"

@protocol GtEditPanelDelegate;

@protocol GtEditPanelProtocol<NSObject>

- (id) initWithDisplayDataRow:(GtDisplayDataRow*) row;

@property (readwrite, assign, nonatomic) id delegate;
@property (readwrite, assign, nonatomic) id userData;
@property (readwrite, assign, nonatomic) GtDisplayDataRow* displayDataRow;
@property (readwrite, assign, nonatomic) NSIndexPath* indexPath;
@end

@interface GtEditPanel : GtViewController<GtEditPanelProtocol> {
@private
	GtDisplayDataRow* m_displayDataRow;
	id m_delegate;
	id m_userData;
	NSIndexPath* m_indexPath;
	BOOL m_wasCancelled;
}

- (void) hideSelf:(id) sender;
- (void) doneButtonPressed;

- (id) onGetNewValue;

@end

@protocol GtEditPanelDelegate<NSObject>
- (void) editPanel:(id<GtEditPanelProtocol>) panel 
       itemUpdated:(GtDisplayDataRow*) dataBinding 
           newData:(id) newData
       atIndexPath:(NSIndexPath*) indexPath;
       
- (void) editPanel:(id<GtEditPanelProtocol>) panel 
   cancelledAtPath:(NSIndexPath*) indexPath;
@end


#endif