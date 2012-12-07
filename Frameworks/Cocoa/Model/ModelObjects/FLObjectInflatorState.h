//
//	FLObjectParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

#import "FLObjectDescriber.h"
#import "FLLinkedList.h"
#import "NSObject+FLParseable.h"

@interface FLObjectInflatorState : FLLinkedListElement {
@private
	NSString* _key;
	id _object;
	id _data;
    FLObjectDescriber* _describer;
	FLDataTypeID _dataType;
	BOOL _dataIsAttribute;
    FLParseInfo* _parseInfo;
}


- (id) initWithObject:(id) object key:(id) key;

+ (FLObjectInflatorState*) objectInflatorState:(id) object key:(id) key;

@property (readwrite, strong, nonatomic) id data;
@property (readwrite, strong, nonatomic) NSString* key; // key for data, like an xml element name
@property (readwrite, strong, nonatomic) id object; // this is the current object to which the data is being added
@property (readwrite, strong, nonatomic) FLObjectDescriber* objectDescriber;
@property (readwrite, strong, nonatomic) FLParseInfo* parseInfo; // may or may not be available, depending on parser 

@property (readwrite, assign, nonatomic) FLDataTypeID parsedDataType;
@property (readwrite, assign, nonatomic) BOOL dataIsAttribute;

@end