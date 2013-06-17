// 
// FLCodeGeneratorOptionsBaseClass.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 1:01 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "FLCodeGeneratorOptionsBaseClass.h"
#import "FLCodeDefine.h"

@implementation FLCodeGeneratorOptionsBaseClass

@synthesize canLazyCreate = _canLazyCreate;
@synthesize comment = _comment;
#if FL_MRC
- (void) dealloc {
    [_userObjectsFolderName release];
    [_typePrefix release];
    [_globalDefine release];
    [_comment release];
    [_objectsFolderName release];
    [super dealloc];
}
#endif
@synthesize disabled = _disabled;
@synthesize generateAllIncludesFile = _generateAllIncludesFile;
@synthesize generateUserObjects = _generateUserObjects;
FLSynthesizeLazyGetter(globalDefine, FLCodeDefine, _globalDefine);
@synthesize globalDefine = _globalDefine;
@synthesize objectsFolderName = _objectsFolderName;
@synthesize typePrefix = _typePrefix;
@synthesize userObjectsFolderName = _userObjectsFolderName;

@end