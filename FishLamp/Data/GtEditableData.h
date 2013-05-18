//
//  GtEditableData.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/8/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
	gtEditableDataEditing,
	gtEditableDataCommitting,
	gtEditableDataCommitted,
	gtEditableDataCommitFailed,
	gtEditableDataEditCancelled

} GtEditableDataState;

@interface GtEditableData : NSObject {
@private
	id m_originalData;
	id m_editedData;
	
	struct {
		unsigned int editCopy:1;
		unsigned int editState:3;
	} m_flags;
}

- (id) initWithOriginalData:(id) data;
- (id) initWithOriginalAndEditedData:(id) data editedData:(id)editedData;

+ (GtEditableData*) editableData:(id) data;
+ (GtEditableData*) editableData:(id) data withEditedData:(id)editedData;

@property (readwrite, retain, nonatomic) id originalData;
@property (readwrite, retain, nonatomic) id editedData;
@property (readwrite, assign, nonatomic) BOOL editCopy; // when beginEditing is calls

@property (readonly, assign, nonatomic) GtEditableDataState editState;

- (void) beginEditing;
@property (readonly, assign, nonatomic) BOOL isEditing;

- (void) beginCommitting;
@property (readonly, assign, nonatomic) BOOL isCommitting;

@property (readonly, assign, nonatomic) BOOL committed;
- (void) setCommitted;

@property (readonly, assign, nonatomic) BOOL committFailed;
- (void) setCommitFailed;

@property (readonly, assign, nonatomic) BOOL editingCancelled;
- (void) setEditingCancelled;


- (void) copyOriginalDataToEditedData;

@end
