// 
// FLTestObjectBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/21/13 5:56 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// 
// Organization: GreenTongue Software, LLC (http://www.greentongue.com)
// Copyright 2013 (c) GreenTongue Software, LLC
// Individual licensees only
// 

#import "FLTestObjectBaseClass.h"
#import "FLGuid.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "FLXmlParser.h"

@implementation FLTestObjectBaseClass

FLSynthesizeLazyGetter(anArray, NSMutableArray, _anArray);
@synthesize anArray = _anArray;
@synthesize anotherInt = _anotherInt;
@synthesize bob = _bob;
@synthesize chloe = _chloe;
@synthesize databaseGuid = _databaseGuid;
@synthesize dateCreated = _dateCreated;
@synthesize dateModified = _dateModified;
#if FL_MRC
- (void) dealloc {
    [_bob release];
    [_rambo release];
    [_foo release];
    [_dateModified release];
    [_foopy release];
    [_dateCreated release];
    [_myString release];
    [_chloe release];
    [_sanjo release];
    [_databaseGuid release];
    [_anArray release];
    [_stateEnum release];
    [_expireDate release];
    [_teddy release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"item" propertyClass:[NSString class]] forContainerProperty:@"anArray"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"number" propertyClass:[NSNumber class]] forContainerProperty:@"anArray"];
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"parser" propertyClass:[FLXmlParser class]] forContainerProperty:@"anArray"];
}
@synthesize expireDate = _expireDate;
@synthesize foo = _foo;
- (NSString*) foop {
    return hello!;
}
+ (NSString*) foopy {
    return hello!;
}
+ (void) setFoopy:(NSString*) value {
}
+ (NSString*) iLikeRum {
    return Captain Morgan;
}
+ (void) setILikeRum:(NSString*) value {
}
@synthesize myBool = _myBool;
@synthesize myString = _myString;
@synthesize point = _point;
@synthesize rambo = _rambo;
@synthesize rect = _rect;
@synthesize sanjo = _sanjo;
@synthesize size = _size;
@synthesize stateEnum = _stateEnum;
- (FLMyEnum) stateEnumEnum {
    return FLMyEnumEnumFromString(self.stateEnum);
}
- (void) setStateEnumEnum:(FLMyEnum) value {
    self.stateEnum = FLMyEnumStringFromEnum(value);
}
- (FLMyEnumEnumSet*) stateEnumEnumSet {
    return [FLMyEnumEnumSet enumSet:self.stateEnum];;
}
- (void) setStateEnumEnumSet:(FLMyEnumEnumSet*) value {
    self.stateEnum = value.concatenatedString;
}
@synthesize teddy = _teddy;
@synthesize testFloat = _testFloat;
@synthesize testInt = _testInt;
+ (id) testObject {
    return FLAutorelease([[[self class] alloc] init]);
}

@end