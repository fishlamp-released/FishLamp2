//
//	FLChooseFromTextListViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringChooserViewController.h"
#import "FLTableViewCell.h"
#import "FLGradientView.h"
#import "FLTableView.h"

@implementation FLStringChooserViewController

@synthesize chosenString = _chosenString;
@synthesize didChooseStringCallback = _chosenCallback;

- (id) initWithStringList:(NSArray*) stringList	 selectedString:(NSString*) selectedString
{
	if((self = [super init]))
	{
        self.wantsApplyTheme = YES;

		_stringList = [stringList copy];
		_initialSelection = FLRetain(selectedString);
	}
	return self;
}

+ (FLStringChooserViewController*) stringChooserViewController:(NSArray*) stringList selectedString:(NSString*) selectedString
{
	return FLAutorelease([[FLStringChooserViewController alloc] initWithStringList:stringList selectedString:selectedString]);
}

- (UIScrollView*) createScrollView
{
    FLTableView* tableView = FLAutorelease([[FLTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain]);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    tableView.autoresizesSubviews = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 32;
    return tableView;
}

- (void)loadView
{
	if(FLStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		FLGradientView* view = FLAutorelease([[FLGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)]);		
		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		view.autoresizesSubviews = YES;
		self.view = view;
	}
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 480-44, 320, 44)];
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _toolbar.barStyle = UIBarStyleBlack;
    _toolbar.translucent = YES;
    _chooseButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Choose", nil) style:UIBarButtonItemStyleDone target:self action:@selector(chooseButtonWasPressed:)];
    
    _toolbar.items = [NSArray arrayWithObjects:
        [UIBarButtonItem flexibleSpaceBarButtonItem],
        _chooseButton,
        [UIBarButtonItem flexibleSpaceBarButtonItem],
        nil
        ];
    
    [self.view addSubview:_toolbar];
}

- (void) viewDidUnload
{
    FLReleaseWithNil(_toolbar);
    FLReleaseWithNil(_chooseButton);
    [super viewDidUnload];
}

- (void) dealloc
{	
	FLRelease(_chosenCallback);
	FLRelease(_chosenString);
	FLRelease(_toolbar);
	FLRelease(_stringList);
	FLRelease(_initialSelection);
	FLRelease(_chooseButton);
	FLSuperDealloc();
}

#if VIEW_AUTOLAYOUT
- (FLViewContentsDescriptor) viewGetSuperviewContentsDescriptor:(UIView*) view
{
	return FLViewContentsDescriptorMake(DeviceIsPad() ? FLViewContentItemNavigationBar : FLViewContentItemNavigationBarAndStatusBar, FLViewContentItemToolbar);
}
#endif

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	if(FLStringIsNotEmpty(_initialSelection))
	{
		int rowNumber = 0;
		for(NSString* string in _stringList)
		{
			if(FLStringsAreEqual(string, _initialSelection))
			{
				[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
				break;
			}
			
			rowNumber++;
		}
	}
}

- (IBAction) chooseButtonWasPressed:(id) sender
{
	FLSetObjectWithRetain(_chosenString, [_stringList objectAtIndex:[self.tableView indexPathForSelectedRow].row]);
	[_chosenCallback invoke:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_chooseButton.enabled = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* s_id = @"cell";

	FLSimpleTextItemTableViewCell* cell = (FLSimpleTextItemTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	
	if(!cell)
	{
		cell = FLAutorelease([[FLSimpleTextItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
//		  cell.themeAction = @selector(applyThemeToStringChooserViewControllerCell:);
//		  [cell applyTheme];
	}
	cell.label.text = [_stringList objectAtIndex:indexPath.row];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return _stringList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

@end
