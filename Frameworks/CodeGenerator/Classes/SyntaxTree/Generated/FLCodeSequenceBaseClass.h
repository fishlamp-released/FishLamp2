// 
// FLCodeSequenceBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 3:02 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"

@class FLObjectDescriber;
@class FLCodeElement;

@interface FLCodeSequenceBaseClass : FLModelObject {
@private
    NSMutableArray* _statements;
}

@property (readwrite, strong, nonatomic) NSMutableArray* statements;

@end
