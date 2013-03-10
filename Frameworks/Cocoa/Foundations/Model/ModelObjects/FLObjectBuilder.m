//
//  FLObjectBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectBuilder.h"
#import "FLObjectDescriber.h"
#import "FLDateMgr.h"
#import "NSObject+FLObjectBuilder.h"

@interface FLObjectBuilder ()
- (void) buildObject:(id) object 
      fromDictionary:(NSDictionary*) dictionary 
 withObjectDescriber:(FLObjectDescriber*) describer
         withDecoder:(id<FLDataDecoding>) decoder;

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
                          forProperty:(FLPropertyDescription*) propertyDescription
                          withDecoder:(id<FLDataDecoding>) decoder;

@property (readwrite, strong, nonatomic) id<FLDataDecoding> dataDecoder;
;

@property (readwrite, strong, nonatomic) id rootObject;

@property (readwrite, strong, nonatomic) NSMutableArray* stack;
@property (readwrite, strong, nonatomic) NSError* error;

@end

@implementation FLObjectBuilder

@synthesize error = _error;
@synthesize dataDecoder = _dataDecoder;
@synthesize delegate = _delegate;
@synthesize rootObject = _rootObject;
@synthesize stack = _stack;

+ (id) objectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_error release];
    [_dataDecoder release];
    [_rootObject release];
    [_stack release];
    [super dealloc];
}
#endif


- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(FLPropertyDescription*) propertyDescription
                              withDecoder:(id<FLDataDecoding>) decoder
{
	NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[fromArray count]];
	
	FLPropertyDescription* arrayItemDesc = [[propertyDescription arrayTypes] objectAtIndex:0];
		
	for(id arrayItem in fromArray)
	{			
		if([arrayItem isKindOfClass:[NSDictionary class]])
		{
			id newObject = FLAutorelease([[arrayItemDesc.propertyType.typeClass alloc] init]);
			[newArray addObject:newObject];
			[self buildObject:newObject fromDictionary:arrayItem withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
		}
		else if([arrayItem isKindOfClass:[NSArray class]]) {
			[newArray addObject:[self addObjectsToArray:arrayItem forProperty:arrayItemDesc withDecoder:decoder]];
		}
		else
		{
            if(decoder) {
                [newArray addObject:[arrayItemDesc.propertyType decodeStringToObject:arrayItem withDecoder:decoder]];
            }
            else {
                [newArray addObject:arrayItem];
            }


//			switch(arrayItemDesc.propertyType.specificType)
//			{
//				case FLSpecificTypeDate:
//					[newArray addObject: [[FLDateMgr instance] ISO8601StringToDate:arrayItem]];
//				break;
//				
//				default:
//                    [newArray addObject:arrayItem];
//				break;
//			}

            


		}
	}
	
	return newArray;
}

- (void) buildObject:(id) object 
      fromDictionary:(NSDictionary*) dictionary 
 withObjectDescriber:(FLObjectDescriber*) describer
         withDecoder:(id<FLDataDecoding>) decoder
{
	for(NSString* key in dictionary)
	{
		id value = [dictionary objectForKey:key];
		if(value)
		{
			FLPropertyDescription* property = [describer.propertyDescribers objectForKey:key];
			if(property)
			{
				if([value isKindOfClass:[NSDictionary class]])
				{
//					FLAssert_v(property.propertyType.generalType == FLGeneralTypeObject, @"not an object?");
				
					id newObject = FLAutorelease([[property.propertyType.typeClass alloc] init]);
					[object setValue:newObject forKey:key];
					[self buildObject:newObject fromDictionary:value withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
				}
				else if([value isKindOfClass:[NSArray class]]) {
					[object setValue:[self addObjectsToArray:value forProperty:property withDecoder:decoder] forKey:key];
				}
				else {

                    if(decoder) {
                        value = [property.propertyType decodeStringToObject:value withDecoder:decoder];
                    }
                
//					switch(property.propertyType.specificType)
//					{
//						case FLSpecificTypeDate:
//							value = [[FLDateMgr instance] ISO8601StringToDate:value];
//						break;
//						
//						default:
//						break;
//					}
					
					[object setValue:value forKey:key];
				}
			}
			else
			{
				FLDebugLog(@"Warning: unknown property for key: %@, value: %@", key, [value description]);
			}
		}
	}
}


- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary 
                     withRootObject:(id) rootObject
                        withDecoder:(id<FLDataDecoding>) decoder {
	[self buildObject:rootObject fromDictionary:dictionary withObjectDescriber:[[rootObject class] sharedObjectDescriber] withDecoder:decoder];
}
	
- (void) openWithRootObjectClass:(Class) theClass withDataDecoder:(id<FLDataDecoding>) decoder {

    self.rootObject = FLAutorelease([[theClass alloc] init]);    
    self.stack = [NSMutableArray array];
    self.dataDecoder = decoder;
    
    [self.stack addObject:[FLPropertyInflator propertyInflator:self.rootObject propertyName:nil state:0]];
}

- (id) finishBuilding {
    id result = nil;
    if(self.error) {
        result = FLRetainWithAutorelease(self.error);
    }
    else {
        result = FLRetainWithAutorelease(self.rootObject);
    }
    self.rootObject = nil;
    self.error = nil;
    self.stack = nil;
    self.dataDecoder = nil;
    
    return result;
}
    
- (NSString*) stateString {
    NSMutableString* string = [NSMutableString string];
    
    for(FLPropertyInflator* state in _stack) {
        
        NSString* key = state.propertyName;
        if(!key) {
            key = NSStringFromClass([state.containingObject class]);
        }
        
        if(string.length > 0) {
            [string appendFormat:@".%@", key];
        } else {
            [string appendString:key];
        }
    }
    
    return string;
}

- (void) setError:(NSError*) error errorHint:(int) errorHint {
//    [super setError:error errorHint:errorHint != nil ? errorHint : [self stateString]];
}

- (FLPropertyInflator*) firstInflator {
    return [_stack firstObject];
}

- (FLPropertyInflator*) lastInflator {
    return [_stack lastObject];
}

- (FLPropertyInflator*) previousStateForState:(FLPropertyInflator*) state {
    
    BOOL next = NO;
    for(FLPropertyInflator* aState in [_stack reverseObjectEnumerator]) {
        if(aState == state) {
            next = YES;
        }
        if(next) {
            return aState;
        }
    }

    return nil;
}

- (FLPropertyInflator*) startInflatingPropertyWithName:(NSString*) propertyName withState:(int) state {
    
   	@try {
        id targetObject = _rootObject;
        if(_stack.count) {
            targetObject = [self.lastInflator containingObject];
        }
        
        FLAssertNotNil_(targetObject);
        
        FLPropertyInflator* newState = [FLPropertyInflator propertyInflator:targetObject propertyName:propertyName state:state];
        [_stack addObject:newState];
        
        if(![targetObject objectBuilder:self beginBuilding:newState]) {
    //        [self setError:[NSError errorWithDomain:FLXmlParserDomain 
    //                                           code:FLXmlParserErrorCodeUnknownElement 
    //                           localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"property", elementName]]
    //                                    errorHint:[self  stateString]];
        }
        
        FLAssertIsNotNil_(newState.containingObject);
    }
    @catch(NSException* ex) {
//        [self setError:ex.error errorHint:[self stateString]];
	}
}

//- (FLPropertyInflator*) startInflatingPropertyWithName:(NSString*) propertyName {
//    return [self startInflatingPropertyWithName:propertyName state:0];
//}

- (void) finishInflatingProperty {
    
    @try {
        FLPropertyInflator* propertyToFinish = FLRetainWithAutorelease(self.stack.lastObject);
        [self.stack removeLastObject];
    
        FLAssertNotNil_(propertyToFinish);
	    FLAssertIsNotNil_(propertyToFinish.containingObject);
        
        [propertyToFinish inflatePropertyWithDataDecoder:self.dataDecoder];

        [self.lastInflator.containingObject objectBuilder:self finishBuilding:propertyToFinish];
    }
	@catch(NSException* ex) {
	    [self setError:ex.error errorHint:[self stateString]];
	}
}
      

- (void) addProperty:(NSString*) propertyName withEncodedString:(NSString*) data withState:(int) state {
    FLPropertyInflator* property = [self startInflatingPropertyWithName:propertyName withState:state];
    [property appendEncodedString:data];
    [self finishInflatingProperty];
}

    
@end
