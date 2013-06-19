// 
// FLTestObjectBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/19/13 3:23 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// 
// Organization: GreenTongue Software, LLC (http://www.greentongue.com)
// Copyright 2013 (c) GreenTongue Software, LLC
// Individual licensees only
// 

#import "FLModelObject.h"
#import "FLMyEnum.h"

@class FLObjectDescriber;
@class FLGuid;
@class FLXmlParser;

@interface FLTestObjectBaseClass : FLModelObject {
@private
    NSString* _bob;
    NSString* _rambo;
    NSString* _foo;
    int _anotherInt;
    CGRect _rect;
    NSDate* _dateModified;
    NSString* _foopy;
    NSDate* _dateCreated;
    NSString* _myString;
    int _testInt;
    CGPoint _point;
    BOOL _myBool;
    NSString* _chloe;
    CGSize _size;
    NSString* _sanjo;
    FLGuid* _databaseGuid;
    NSMutableArray* _anArray;
    float _testFloat;
    NSString* _stateEnum;
    NSDate* _expireDate;
    NSString* _teddy;
}

@property (readwrite, strong, nonatomic) NSMutableArray* anArray;
@property (readwrite, assign, nonatomic) int anotherInt;
@property (readwrite, strong, nonatomic) NSString* bob;
@property (readwrite, strong, nonatomic) NSString* chloe;
@property (readwrite, strong, nonatomic) FLGuid* databaseGuid;
@property (readwrite, strong, nonatomic) NSDate* dateCreated;
@property (readwrite, strong, nonatomic) NSDate* dateModified;
@property (readwrite, strong, nonatomic) NSDate* expireDate;
@property (readwrite, strong, nonatomic) NSString* foo;
@property (readonly, strong, nonatomic) NSString* foop;
+ (NSString*) foopy;
+ (void) setFoopy:(NSString*) value;
+ (NSString*) iLikeRum;
+ (void) setILikeRum:(NSString*) value;
@property (readwrite, assign, nonatomic) BOOL myBool;
@property (readwrite, strong, nonatomic) NSString* myString;
@property (readwrite, assign, nonatomic) CGPoint point;
@property (readwrite, strong, nonatomic) NSString* rambo;
@property (readwrite, assign, nonatomic) CGRect rect;
@property (readwrite, strong, nonatomic) NSString* sanjo;
@property (readwrite, assign, nonatomic) CGSize size;
@property (readwrite, strong, nonatomic) NSString* stateEnum;
@property (readwrite, assign, nonatomic) FLMyEnum stateEnumEnum;
@property (readwrite, strong, nonatomic) FLMyEnumEnumSet* stateEnumEnumSet;
@property (readwrite, strong, nonatomic) NSString* teddy;
@property (readwrite, assign, nonatomic) float testFloat;
@property (readwrite, assign, nonatomic) int testInt;

+ (id) testObject;

@end
