//
//	GtObjectParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define NEW_PARSER 1

#import "GtObjectDescriber.h"

@interface GtObjectInflatorState : NSObject {
	NSString* m_key;
	id m_object;
	id m_data;
#if NEW_PARSER
	GtObjectDescriber* m_describer;
	GtDataTypeID m_dataType;
#else
	GtDataTypeStruct* m_type;
#endif
	GtObjectInflatorState* m_prev;
	struct {
		BOOL dataIsAttribute:1;
	} m_flags;
}

@property (readwrite, retain, nonatomic) id data;
@property (readwrite, retain, nonatomic) NSString* key; // key for data, like an xml element name
@property (readwrite, retain, nonatomic) id object; // this is the current object to which the data is being added
@property (readwrite, assign, nonatomic) BOOL dataIsAttribute;

#if NEW_PARSER
@property (readwrite, retain, nonatomic) GtObjectDescriber* objectDescriber;
@property (readwrite, assign, nonatomic) GtDataTypeID parsedDataType;
#else
@property (readwrite, assign, nonatomic) GtDataTypeStruct* type; // type for the object, this is a linked list.
#endif

@property (readwrite, retain, nonatomic) GtObjectInflatorState* prev; // previous element on the stack

@end