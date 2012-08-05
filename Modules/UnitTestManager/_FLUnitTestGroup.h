

@interface FLUnitTestGroup ()

- (id) initWithClass:(Class) aClass;

+ (FLUnitTestGroup*) unitTestGroup:(Class) aClass;

@property (readonly, retain, nonatomic) NSArray* unitTests;
@property (readwrite, retain, nonatomic) NSString* groupName;

- (void) addUnitTest:(FLUnitTest*) test;

- (void) setup;
- (void) tearDown;
@end