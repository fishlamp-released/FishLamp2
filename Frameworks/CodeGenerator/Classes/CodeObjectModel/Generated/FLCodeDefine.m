// 
// FLCodeDefine.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 


#import "FLCodeDefine.h"
#import "FLModelObject.h"

@implementation FLCodeDefine

+ (id) codeDefine {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize comment = _comment;
#if FL_MRC
- (void) dealloc {
    [_value release];
    [_comment release];
    [_define release];
    [super dealloc];
}
#endif
@synthesize define = _define;
@synthesize isString = _isString;
@synthesize value = _value;

@end
