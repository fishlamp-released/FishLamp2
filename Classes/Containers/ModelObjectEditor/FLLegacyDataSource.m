//
//	FLDataSouce.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLLegacyDataSource.h"
#import "NSObject+Comparison.h"
#import "FLOrderedCollection.h"

#define AssignToVoid(s) ((__bridge_fl void*) s)

FLSplitKeyPath FLSplitKeyPathFromString(NSString* keyPathString)
{
	FLSplitKeyPath keyPath;
	NSRange range = [keyPathString rangeOfString:@"."];
   
	if(range.length == 0)
	{
		keyPath.dataSourceKey = nil;
		keyPath.dataKey = autorelease_(retain_(keyPathString));
	}
	else 
	{
		keyPath.dataSourceKey = [keyPathString substringToIndex:range.location];
		keyPath.dataKey = [keyPathString substringFromIndex:range.location+1];
	}
   
	return keyPath;
}

@implementation FLLegacyDataSource

@synthesize delegate = _delegate;

- (NSDictionary*) dataSources
{
	return _dataSources;
}

- (id) init
{
	if((self = [super init]))
	{
		_dataSources = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	release_(_dataSources);
	super_dealloc_();
}

- (void) setDataSource:(id) dataSource forKey:(NSString*) key
{   
    FLAssertStringIsNotEmpty_(key);

    if(dataSource)
    {
        [_dataSources setObject:dataSource forKey:key];
    }
    else
    {
        [_dataSources removeObjectForKey:key];
    }
}

- (id) defaultDataSource
{	
	return [_dataSources objectForKey:@""];
}

- (void) setDefaultDataSource:(id) dataSource
{
	[_dataSources setObject:dataSource forKey:@""];
}

- (id) dataSourceForDataSourceKey:(NSString*) key
{
	return FLStringIsEmpty(key) ? self.defaultDataSource : [_dataSources objectForKey:key];
}

- (id) dataSourceForKeyPath:(NSString*) keyPath
{
	FLSplitKeyPath path = FLSplitKeyPathFromString(keyPath);
	return [self dataSourceForDataSourceKey:path.dataSourceKey];
}

- (id) objectForKeyPath:(NSString*) keyPathString
{
	FLSplitKeyPath path = FLSplitKeyPathFromString(keyPathString);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];

	return dataSource ? [dataSource dataSourceManager:self objectForKey:path.dataKey] : nil;
}

- (void) setObject:(id) object forKeyPath:(NSString*) keyPathString fireDataChangedEvent:(BOOL) fire
{
	FLSplitKeyPath path = FLSplitKeyPathFromString(keyPathString);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];

	if(dataSource)
	{
		id previousValue = [dataSource dataSourceManager:self objectForKey:path.dataKey];
		mrc_autorelease_(retain_(previousValue));
		
		if(![[object class] objectIsEqualToObject:object toObject:previousValue])
		{
			[dataSource dataSourceManager:self setObject:object forKey:path.dataKey];
				
			if(fire)
			{
				[_delegate dataSourceManager:self dataChangedForKeyPath:keyPathString newValue:object previousValue:previousValue];
			}
		}
	}
}

- (void) removeObjectForKeyPath:(NSString*) keyPath fireDataChangedEvent:(BOOL) fire
{
	FLSplitKeyPath path = FLSplitKeyPathFromString(keyPath);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];
	if(dataSource)
	{
		id previousValue = [dataSource dataSourceManager:self objectForKey:path.dataKey];
		mrc_autorelease_(retain_(previousValue));
			
		[dataSource dataSourceManager:self removeObjectForKey:path.dataKey];
		if(fire)
		{
			[_delegate dataSourceManager:self dataRemovedForKeyPath:path.dataKey previousValue:previousValue];
		}
	}
}

- (BOOL) objectExistsForKeyPath:(NSString*) keyPath
{
	FLSplitKeyPath path = FLSplitKeyPathFromString(keyPath);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];
	return dataSource ? [dataSource dataSourceManager:self objectExistsForKey:path.dataKey] : NO;
}

@end

@implementation NSMutableDictionary (FLAbstactedDataSourceAdaptor)

- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

- (id) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectForKey:(id) key
{	
	return [self objectForKey:key];
}
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self setObject:object forKey:key];
}
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager removeObjectForKey:(id) key
{
	[self removeObjectForKey:key];
}
- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectExistsForKey:(id) key
{
	return [self objectForKey:key] != nil;
}
@end

@implementation NSObject (FLAbstactedDataSourceAdaptor)

- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self valueForKey:key] != nil; // TODO: not sure this is correct?
}

- (id) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectForKey:(id) key
{	
	id outValue = nil;
//	// this works around a problem where keyValue encoding was boxing a long value incorrectly into a 32bit number.
//	
//	FLDataTypeStruct* dataInfo = [[self class] propertyDataTypeStructByName:key];
//	if(dataInfo)
//	{
//		outValue = FLPerformDataTypeStructGetter(self, dataInfo);
//	}
//	else
	{
		outValue = [self valueForKey:key];
	}
	
	return outValue;
}
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self setValue:object forKey:key];
}
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager removeObjectForKey:(id) key
{
	[self setValue:nil forKey:key];
}
- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectExistsForKey:(id) key
{
	return [self valueForKey:key] != nil;
}
@end

//@implementation OMObject (FLLegacyDataSourceAdaptor)
//
//- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager ownsObjectForKey:(id) key
//{
//	  return [[self dataDescriptors] objectForKey:key] != nil;
//}
//
//- (id) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectForKey:(id) key
//{
//	  return [self objectForKey:key]; // this will create a default value if nil!
//}
//
//- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager setObject:(id) object forKey:(id) key
//{
//	  [self.objectData setObject:object forKey:key];
//}
//
//- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager removeObjectForKey:(id) key
//{
//	  [self.objectData removeObjectForKey:key];
//}
//
//- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectExistsForKey:(id) key
//{
//	  return [self.objectData objectForKey:key] != nil;
//}
//
//@end

@implementation FLOrderedCollection (FLLegacyDataSourceAdaptor)

- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

- (id) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectForKey:(id) key
{
	return [self objectForKey:key]; // this will create a default value if nil!
}

- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self addOrReplaceObject:object forKey:key];
}

- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager removeObjectForKey:(id) key
{
	[self removeObjectForKey:key];
}

- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectExistsForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

@end


@implementation NSObject (FLKeyPath)
+ (NSString*) keyPathWithDataKey:(NSString*) dataKey
{
	return FLKeyPathStringMake(NSStringFromClass([self class]), dataKey);
}
+ (NSString*) dataSourceKey
{	
	return NSStringFromClass([self class]);
}

@end


