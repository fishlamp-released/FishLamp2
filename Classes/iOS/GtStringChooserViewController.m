//
//	GtChooseFromTextListViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringChooserViewController.h"
#import "GtTableViewCell.h"
#import "GtGradientView.h"
#import "GtTableView.h"

@implementation GtStringChooserViewController

@synthesize chosenString = m_chosenString;
@synthesize didChooseStringCallback = m_chosenCallback;

- (id) initWithStringList:(NSArray*) stringList	 selectedString:(NSString*) selectedString
{
	if((self = [super init]))
	{
		m_stringList = [stringList copy];
		m_initialSelection = GtRetain(selectedString);
	}
	return self;
}

+ (GtStringChooserViewController*) stringChooserViewController:(NSArray*) stringList selectedString:(NSString*) selectedString
{
	return GtReturnAutoreleased([[GtStringChooserViewController alloc] initWithStringList:stringList selectedString:selectedString]);
}

- (UIScrollView*) createScrollView
{
    GtTableView* tableView = GtReturnAutoreleased([[GtTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain]);
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
	if(GtStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		GtGradientView* view = GtReturnAutoreleased([[GtGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)]);		
		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		view.autoresizesSubviews = YES;
		self.view = view;
	}
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    m_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 480-44, 320, 44)];
    m_toolbar.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    m_toolbar.barStyle = UIBarStyleBlack;
    m_toolbar.translucent = YES;
    m_chooseButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Choose", nil) style:UIBarButtonItemStyleDone target:self action:@selector(chooseButtonWasPressed:)];
    
    m_toolbar.items = [NSArray arrayWithObjects:
        [UIBarButtonItem flexibleSpaceBarButtonItem],
        m_chooseButton,
        [UIBarButtonItem flexibleSpaceBarButtonItem],
        nil
        ];
    
    [self.view addSubview:m_toolbar];
}

- (void) viewDidUnload
{
    GtReleaseWithNil(m_toolbar);
    GtReleaseWithNil(m_chooseButton);
    [super viewDidUnload];
}

- (void) dealloc
{	
	GtRelease(m_chosenCallback);
	GtRelease(m_chosenString);
	GtRelease(m_toolbar);
	GtRelease(m_stringList);
	GtRelease(m_initialSelection);
	GtRelease(m_chooseButton);
	GtSuperDealloc();
}

#if VIEW_AUTOLAYOUT
- (GtViewContentsDescriptor) viewGetSuperviewContentsDescriptor:(UIView*) view
{
	return GtViewContentsDescriptorMake(DeviceIsPad() ? GtViewContentItemNavigationBar : GtViewContentItemNavigationBarAndStatusBar, GtViewContentItemToolbar);
}
#endif

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	if(GtStringIsNotEmpty(m_initialSelection))
	{
		int rowNumber = 0;
		for(NSString* string in m_stringList)
		{
			if(GtStringsAreEqual(string, m_initialSelection))
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
	GtAssignObject(m_chosenString, [m_stringList objectAtIndex:[self.tableView indexPathForSelectedRow].row]);
	[m_chosenCallback invoke:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	m_chooseButton.enabled = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* s_id = @"cell";

	GtSimpleTextItemTableViewCell* cell = (GtSimpleTextItemTableViewCell*) [tableView dequeueReusableCellWithIdentifier:s_id];
	
	if(!cell)
	{
		cell = GtReturnAutoreleased([[GtSimpleTextItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_id]);
//		  cell.themeAction = @selector(applyThemeToStringChooserViewControllerCell:);
//		  [cell applyTheme];
	}
	cell.label.text = [m_stringList objectAtIndex:indexPath.row];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return m_stringList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

@end
