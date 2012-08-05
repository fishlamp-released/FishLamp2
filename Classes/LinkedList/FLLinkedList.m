//
//	FLLinkedList.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLinkedList.h"

#if DEBUG
#define HARDCORE_CHECKING_ACTION 1
#endif

@interface FLLinkedList ()
@property (readwrite, retain, nonatomic) id firstObject;
@property (readwrite, retain, nonatomic) id lastObject;
@property (readwrite, assign, nonatomic) NSUInteger count;
@end

@implementation FLLinkedList

@synthesize lastObject = _lastObject;
@synthesize firstObject = _firstObject;
@synthesize count = _count;

- (id) init {
    self = [super init]; 
    if(self) {
    
    }
    
    return self;
}

+ (FLLinkedList*) linkedList {
    return FLReturnAutoreleased([[FLLinkedList alloc] init]);
}

- (void) dealloc {
	if(_count) {
        [self removeAllObjects];
    }

    FLSuperDealloc();
}

#if DEBUG

- (void) assertIsInList:(id) object
{
//	  FLAssertIsNotNil(object.linkedList);
	if(object != self.firstObject && object != self.lastObject) {
		FLAssertIsNotNil([object nextObjectInLinkedList]);
		FLAssertIsNotNil([object previousObjectInLinkedList]);
	}
	else if(object == self.firstObject) {
		FLAssertIsNil([object previousObjectInLinkedList]); 
	}
	else if(object == self.lastObject) {
		FLAssertIsNil([object nextObjectInLinkedList]); 
	}
}

- (void) check {
	NSUInteger count = 0;
	for(id object in self) {
		[self assertIsInList:object];
		++count;
	}
	FLAssert(_count == count, @"wrong count");
	
	count = 0;
	id walker = self.firstObject;
	while(walker) {
		[self assertIsInList:walker];
	   ++count;
		walker = [walker nextObjectInLinkedList];
	}
	FLAssert(_count == count, @"wrong count");
	
	count = 0;
	walker = self.lastObject;
	while(walker) {
		[self assertIsInList:walker];
	   ++count;
		walker = [walker previousObjectInLinkedList];
	}

	FLAssert(_count == count, @"wrong count");
	if(_count == 0) {
		FLAssertIsNil(self.firstObject);
		FLAssertIsNil(self.lastObject);
	}
}


#endif

- (void) _insertObject:(id) object 
          beforeObject:(id) beforeObject
{
	FLAssertIsNotNil(object);
	FLAssert(beforeObject != object, @"can't push before self!");
	
	FLAssert([object nextObjectInLinkedList] == nil, @"already in a list");
	FLAssert([object previousObjectInLinkedList] == nil, @"already in a list");
	
	++_mutatationCount;
    
	if(beforeObject == self.firstObject) {
		if(!self.lastObject)  {
			self.lastObject = object;
			[object setNextObjectInLinkedList:nil];
		} 
		
		if(self.firstObject) {
			[self.firstObject setPreviousObjectInLinkedList:object];
			[object setNextObjectInLinkedList:self.firstObject];
		}

		self.firstObject = object;
		[self.firstObject setPreviousObjectInLinkedList:nil];
	}
	else {
		FLAssertIsNotNil(beforeObject);
	
        [object setNextObjectInLinkedList:beforeObject];
        [object setPreviousObjectInLinkedList:[beforeObject previousObjectInLinkedList]];
       
        [[beforeObject previousObjectInLinkedList] setNextObjectInLinkedList: object];
        [beforeObject setPreviousObjectInLinkedList:object];
	}
}

- (void) _insertObject:(id) object 
           afterObject:(id) afterObject {
	FLAssertIsNotNil(object);
	FLAssert(afterObject != object, @"can't append after self!");
	FLAssert([object nextObjectInLinkedList] == nil, @"already in a list");
	FLAssert([object previousObjectInLinkedList] == nil, @"already in a list");
	
    ++_mutatationCount;

	if(afterObject == self.lastObject) {
		if(!self.firstObject) {
			self.firstObject = object;
			[object setPreviousObjectInLinkedList:nil];
		} 
		
		if(self.lastObject)
		{
			[self.lastObject setNextObjectInLinkedList:object];
            [object setPreviousObjectInLinkedList:self.lastObject];
  		}

		self.lastObject = object;
		[self.lastObject setNextObjectInLinkedList:nil];
	}
	else {
		FLAssertIsNotNil(afterObject);
   
		[object setNextObjectInLinkedList:[afterObject nextObjectInLinkedList]];
		[object setPreviousObjectInLinkedList:afterObject];
		
		[[afterObject nextObjectInLinkedList] setPreviousObjectInLinkedList:object];
		[afterObject setNextObjectInLinkedList:object];
	}
}

- (void) _removeObject:(id) object {

	FLAssertIsNotNil(object);
    
	++_mutatationCount;

	if(self.firstObject == object) {
		self.firstObject = [object nextObjectInLinkedList];
		[self.firstObject setPreviousObjectInLinkedList:nil];
	}
	else {
		[[object nextObjectInLinkedList] setPreviousObjectInLinkedList:[object previousObjectInLinkedList]];
	}
    
	if(self.lastObject == object) {
		self.lastObject = [object previousObjectInLinkedList];
		[self.lastObject setNextObjectInLinkedList:nil];
	}
	else {
		[[object previousObjectInLinkedList] setNextObjectInLinkedList:[object nextObjectInLinkedList]];
	}
	[object setNextObjectInLinkedList:nil];
	[object setPreviousObjectInLinkedList:nil];
    
	FLAssert(_count > 0, @"count is invalid");
    
}

- (void) _addObject:(id) object adder:(void (^)(FLLinkedList* list)) adder {

    FLAssert([object linkedList] == nil, @"object already in a list");
    
    if(![object linkedList]) {
        adder(self);
        ++_count;
        [object setLinkedList:self];
    }

#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
}

- (id) insertObject:(id) object 
        afterObject: (id) afterObject {
    
    [self _addObject:object adder:^(FLLinkedList* list){ 
        [list _insertObject:object afterObject:afterObject]; 
    }];
    
    return object;
}

- (id) insertObject:(id) object 
       beforeObject:(id) beforeObject {

    [self _addObject:object adder:^(FLLinkedList* list){ 
        [list _insertObject:object beforeObject:beforeObject];
    }];

    return object;
}

- (id) pushObject:(id) object {

    [self _addObject:object adder:^(FLLinkedList* list){ 
        [list _insertObject:object beforeObject:self.firstObject];
    }];

    return object;
}

- (id) addObject:(id) object {

    [self _addObject:object adder:^(FLLinkedList* list){ 
        [list _insertObject:object afterObject:self.lastObject];
    }];
    
    return object;
}

- (id) removeObject:(id) object {

    if([object linkedList] == self) {
        FLRetain(FLReturnAutoreleased(object));
    
        [self _removeObject:object];
        [object setLinkedList:nil];
        --_count;
    }
    
#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
    
    return object;
}

- (id) removeFirstObject {
    return self.firstObject ? [self removeObject:self.firstObject] : nil;
}

- (id) removeLastObject {
    return self.lastObject ? [self removeObject:self.lastObject] : nil;
}

- (id) moveObjectToHead:(id) object {

    FLRetain(object);
	[self _removeObject:object];
	[self _insertObject:object beforeObject:self.firstObject];
    FLRelease(object);
    
#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
	
	return object;
}

- (id) moveObjectToTail:(id) object {

    FLRetain(object);
	[self _removeObject:object];
	[self _insertObject:object afterObject:self.lastObject];
    FLRelease(object);
    
#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
	
	return object;
}

- (id) moveObject:(id) object afterObject:(id) afterObject {

    FLRetain(object);
	[self _removeObject:object];
	[self _insertObject:object afterObject:afterObject];
    FLRelease(object);

#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
	
	return object;
}

- (id) moveObject:(id) object beforeObject:(id) beforeObject {

    FLRetain(object);
	[self _removeObject:object];
	[self _insertObject:object beforeObject:beforeObject];
    FLRelease(object);
	 
#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
	
	return object;
}

- (void) swapListPositions:(id) firstObject secondObject:(id) secondObject {
    FLAssertIsNotNil(firstObject);
    FLAssertIsNotNil(secondObject);
    FLAssert([firstObject linkedList] == self, @"first object is not in linked list");
    FLAssert([secondObject linkedList] == self, @"second object is not in linked list");
    FLAssert(firstObject != secondObject, @"first and second object are the same");

    ++_mutatationCount;
    
    FLRetain(firstObject);
    FLRetain(secondObject);

    
    id firstObjectNext = [firstObject nextObjectInLinkedList];
    id secondObjectNext = [secondObject nextObjectInLinkedList];

    if(secondObjectNext == firstObject) {
        [self moveObject:secondObject afterObject:firstObject];
    }
    else if(firstObjectNext == secondObject) {
        [self moveObject:firstObject afterObject:secondObject];
    }
    else {
        id secondObjectPrev = [secondObject previousObjectInLinkedList];
        id firstObjectPrev = [firstObject previousObjectInLinkedList];
        
        if(firstObjectNext) {
            [self moveObject:secondObject beforeObject:firstObjectNext];
        }
        else {
            [self moveObject:secondObject afterObject:firstObjectPrev];
        }
        
        if(secondObjectNext) {
            [self moveObject:firstObject beforeObject:secondObjectNext];
        }
        else {
            [self moveObject:firstObject afterObject:secondObjectPrev];
        }
    }
    
    FLRelease(firstObject);
    FLRelease(secondObject);
}

- (void) removeAllObjects {

	++_mutatationCount;
    
    id walker = self.firstObject;
	while(walker) {
        
        id objectToRemove = walker;
        FLRetain(objectToRemove);
		walker = [walker nextObjectInLinkedList];
		
        [self _removeObject:objectToRemove];
        [objectToRemove setLinkedList:nil];
        FLRelease(objectToRemove);
    
        --_count;
    }
    
    FLAssertIsNil(_firstObject);
    FLAssertIsNil(_lastObject);
    FLAssert(_count == 0, @"count is not zero");
	
#if HARDCORE_CHECKING_ACTION
	[self check];
#endif
}

- (FLLinkedList*) moveAllObjectsToNewList {
    FLLinkedList* list = [FLLinkedList linkedList];
    list.firstObject = self.firstObject;
    list.lastObject = self.lastObject;
    list.count = self.count;
    FLReleaseWithNil(_firstObject);
    FLReleaseWithNil(_lastObject);
    _count = 0;
    return list;
}

- (NSString*) description {
	NSMutableString* output = [NSMutableString stringWithString:[super description]];
	
    [output appendFormat:@" Count: %ld\n", (long)self.count];
    
	id walker = self.firstObject;
	while(walker) {
		[output appendFormat:@"%@\n", [walker description]];
	
		walker = [walker nextObjectInLinkedList];
	}
	
	return output;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                  objects:(id __unsafe_unretained [])buffer 
                                    count:(NSUInteger)len {
	id currentObject;
	if (state->state == 0) {
		// Set the starting point. _startOfListObject is assumed to be our
		// object's instance variable that points to the start of the list.
		currentObject = self.firstObject;
	}
	else if(state->state == NSIntegerMax) {
		return 0;
	}	
	else {
		// Subsequent iterations, get the current progress out of state->state
		currentObject = (__fl_bridge id) ((void*) state->state);
	}
	
	// Accumulate nodes from the list until we reach the object's
	// _endOfListPlusOneObject
	NSUInteger batchCount = 0;
	while (currentObject != nil && batchCount < len) {
		buffer[batchCount] = currentObject;
		currentObject = [currentObject nextObjectInLinkedList];
		batchCount++;
	}

	state->state = currentObject == nil ? NSIntegerMax : (unsigned long) (__fl_bridge void*)currentObject;
	state->itemsPtr = buffer;
	state->mutationsPtr = &_mutatationCount;

	return batchCount;
}

void FLMergeSortSplitLists(
    id head, 
    id tail,
    id* frontHead, 
    id* frontTail, 
    id* backHead, 
    id* backTail) {

    id fast = nil;
    id slow = nil;

    if (head == nil || [head nextObjectInLinkedList] == nil) {
    /* length < 2 cases */
        *frontHead = head;
        *frontTail = tail;
        
        *backHead = nil;
        *backTail = nil;
    }
    else {
        slow = head;
        fast = [head nextObjectInLinkedList];

        /* Advance 'fast' two nodes, and advance 'slow' one node */
        while (fast != nil) {
            fast = [fast nextObjectInLinkedList];
            if (fast != nil) {
                slow = [slow nextObjectInLinkedList];
                fast = [fast nextObjectInLinkedList];
            }
        }

    /* 'slow' is before the midpoint in the list, so split it in two
      at that point. */
        *frontHead = head;
        *frontTail = slow;
        *backHead = [slow nextObjectInLinkedList];
        
        // sever the two lists
        [*backHead setPreviousObjectInLinkedList:nil];
        [*frontTail setNextObjectInLinkedList:nil];
        
        *backTail = tail;
    }    
}

id FLSortedMerge(
    id frontHead, 
    id backHead, 
    id* newTail,
    NSComparator comparator) {
  /* Base cases */
    if (frontHead == nil) {
        return backHead;
    }
    else if(backHead == nil) {
        return frontHead;
    }
    
    id result = nil;
    id next = nil;
    if(comparator(frontHead, backHead) == NSOrderedAscending)  {
        result = frontHead;
        next = FLSortedMerge([frontHead nextObjectInLinkedList], backHead, newTail, comparator);
    }
    else {
        result = backHead;
        next = FLSortedMerge(frontHead, [backHead nextObjectInLinkedList], newTail, comparator);
    }

    [result setNextObjectInLinkedList:next];
    [next setPreviousObjectInLinkedList:result];
    
    if(*newTail){
        *newTail = nil;
    }
    *newTail = result;
    
    return result;
}

void FLMergeSort(
    id* firstObject, 
    id* lastObject,
    NSComparator comparator) {
    id head = *firstObject;
    
    /* Base case -- length 0 or 1 */
    if( head == nil || [head nextObjectInLinkedList] == nil) {
        return;
    }

    id tail = *lastObject;
    id frontHead = nil;
    id frontTail = nil;
    id backHead = nil;
    id backTail = nil;
 
  /* Split head into 'a' and 'b' sublists */
    FLMergeSortSplitLists(head, tail, &frontHead, &frontTail, &backHead, &backTail);
  
    /* Recursively sort the sublists */
    FLMergeSort(&frontHead, &frontTail, comparator);
    FLMergeSort(&backHead, &backTail, comparator);
    
    *firstObject = FLSortedMerge(frontHead, backHead, lastObject, comparator);
}

- (void)sortUsingComparator:(NSComparator) comparator {
    
    ++_mutatationCount;
    
    if(self.count <= 1) {
        return;
    }

    id oldFirst = self.firstObject;
    id oldLast = self.lastObject;
    id first = oldFirst;
    id last = oldLast;
    
    FLMergeSort(&first, &last, comparator);
    
    self.firstObject = first;
    self.lastObject = last;
} 

@end

#if 0

#include<stdio.h>
#include<stdlib.h>
 
/* Link list node */
struct node
{
    int data;
    struct node* next;
};
 
/* function prototypes */
struct node* SortedMerge(struct node* a, struct node* b);
void FrontBackSplit(struct node* source,
          struct node** frontRef, struct node** backRef);
 

void FrontBackSplit(struct node* source,
          struct node** frontRef, struct node** backRef)
{
  struct node* fast;
  struct node* slow;
  if (source==NULL || source->next==NULL)
  {
    /* length < 2 cases */
    *frontRef = source;
    *backRef = NULL;
  }
  else
  {
    slow = source;
    fast = source->next;
 
    /* Advance 'fast' two nodes, and advance 'slow' one node */
    while (fast != NULL)
    {
      fast = fast->next;
      if (fast != NULL)
      {
        slow = slow->next;
        fast = fast->next;
      }
    }
 
    /* 'slow' is before the midpoint in the list, so split it in two
      at that point. */
    *frontRef = source;
    *backRef = slow->next;
    slow->next = NULL;
  }
}
 
/* sorts the linked list by changing next pointers (not data) */
void MergeSort(struct node** headRef)
{
  struct node* head = *headRef;
  struct node* a;
  struct node* b;
 
  /* Base case -- length 0 or 1 */
  if ((head == NULL) || (head->next == NULL))
  {
    return;
  }
 
  /* Split head into 'a' and 'b' sublists */
  FrontBackSplit(head, &a, &b); 
 
  /* Recursively sort the sublists */
  MergeSort(&a);
  MergeSort(&b);
 
  /* answer = merge the two sorted lists together */
  *headRef = SortedMerge(a, b);
}
 
/* See http://geeksforgeeks.org/?p=3622 for details of this
   function */
struct node* SortedMerge(struct node* a, struct node* b)
{
  struct node* result = NULL;
 
  /* Base cases */
  if (a == NULL)
     return(b);
  else if (b==NULL)
     return(a);
 
  /* Pick either a or b, and recur */
  if (a->data <= b->data)
  {
     result = a;
     result->next = SortedMerge(a->next, b);
  }
  else
  {
     result = b;
     result->next = SortedMerge(a, b->next);
  }
  return(result);
}
 
/* UTILITY FUNCTIONS */
/* Split the nodes of the given list into front and back halves,
     and return the two lists using the reference parameters.
     If the length is odd, the extra node should go in the front list.
     Uses the fast/slow pointer strategy.  */
void FrontBackSplit(struct node* source,
          struct node** frontRef, struct node** backRef)
{
  struct node* fast;
  struct node* slow;
  if (source==NULL || source->next==NULL)
  {
    /* length < 2 cases */
    *frontRef = source;
    *backRef = NULL;
  }
  else
  {
    slow = source;
    fast = source->next;
 
    /* Advance 'fast' two nodes, and advance 'slow' one node */
    while (fast != NULL)
    {
      fast = fast->next;
      if (fast != NULL)
      {
        slow = slow->next;
        fast = fast->next;
      }
    }
 
    /* 'slow' is before the midpoint in the list, so split it in two
      at that point. */
    *frontRef = source;
    *backRef = slow->next;
    slow->next = NULL;
  }
}
 
/* Function to print nodes in a given linked list */
void printList(struct node *node)
{
  while(node!=NULL)
  {
   printf("%d ", node->data);
   node = node->next;
  }
}
 
/* Function to insert a node at the beginging of the linked list */
void push(struct node** head_ref, int new_data)
{
  /* allocate node */
  struct node* new_node =
            (struct node*) malloc(sizeof(struct node));
 
  /* put in the data  */
  new_node->data  = new_data;
 
  /* link the old list off the new node */
  new_node->next = (*head_ref);    
 
  /* move the head to point to the new node */
  (*head_ref)    = new_node;
} 
 
/* Drier program to test above functions*/
int main()
{
  /* Start with the empty list */
  struct node* res = NULL;
  struct node* a = NULL;
 
  /* Let us create a unsorted linked lists to test the functions
   Created lists shall be a: 2->3->20->5->10->15 */
  push(&a, 15);
  push(&a, 10);
  push(&a, 5);
  push(&a, 20);
  push(&a, 3);
  push(&a, 2); 
 
  /* Sort the above created Linked List */
  MergeSort(&a);
 
  printf("\n Sorted Linked List is: \n");
  printList(a);           
 
  getchar();
  return 0;
}


#endif










