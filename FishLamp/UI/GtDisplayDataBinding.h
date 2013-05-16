//
//  GtDisplayDataBinding.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtDataContainer.h"

#import "GtDisplayFormatter.h"

#import "GtEditableDataProtocol.h"

@interface GtDisplayDataBinding : NSObject<GtEditableDataProtocol> {
@private
	id<GtDataContainerProtocol> m_dataContainer;
	
	id m_dataId;
	id m_previousValue;
	id m_newValue;
	BOOL m_committing;
	BOOL m_editable;
}

- (id) initWithDataContainer:(id<GtDataContainerProtocol>) container;

@property (readwrite, retain, nonatomic) id dataId;
@property (readwrite, retain, nonatomic) id<GtDataContainerProtocol> dataContainer;
@property (readwrite, retain, nonatomic) id object; // contained by data container


@end

