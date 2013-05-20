//
//	GtSlideShowOptionsViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSlideShowOptionsViewController.h"
#import "GtSliderValueCell.h"
#import "GtOnOffSwitchCell.h"
#import "GtButtonCell.h"
#import "GtGradientButton.h"

@interface GtMediaItemArrayFormatter : NSObject
@end

@implementation GtSlideshowOptionsViewController

@synthesize slideshowOptionsDelegate = m_slideshowDelegate;

- (id) initWithSlideshowOptions:(GtSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton
{
	if((self = [super init]))
	{
		self.title = NSLocalizedString(@"Slideshow Options", nil);
		m_options = GtRetain(options);
		m_showButton = showStartNowButton;
	}
	return self;
}

+ (GtSlideshowOptionsViewController*) slideshowOptionsViewController:(GtSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton
{
	return GtReturnAutoreleased([[GtSlideshowOptionsViewController alloc] initWithSlideshowOptions:options showStartNowButton:showStartNowButton]);
}

- (void) dealloc
{
	GtRelease(m_options);
	GtSuperDealloc();
}

- (GtSlideshowOptions*) options
{
	return m_options;
}

- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager
{
	[dataSourceManager setDataSource:m_options forKey:[GtSlideshowOptions dataSourceKey]];
}

- (void) beginSlideshow:(id) sender
{
	[self dismissViewControllerAnimated:YES];
	[m_slideshowDelegate slideshowOptionsViewController:self beginSlideshowWithOptions:self.options];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
	NSArray* list = GtReturnAutoreleased([mediaItemCollection.items mutableCopy]);

	[self.dataSourceManager setObject:list 
			forKeyPath:[GtSlideshowOptions keyPathWithDataKey:[GtSlideshowOptions mediaItemListKey]] 
			fireDataChangedEvent:YES];
	
	[self.dataSourceManager setObject:[NSNumber numberWithBool:mediaItemCollection.items.count >= 1] 
		forKeyPath:[GtSlideshowOptions keyPathWithDataKey:[GtSlideshowOptions playMusicKey]] 
		fireDataChangedEvent:YES];

	[self.navigationController popViewControllerAnimated:YES];
	[self.tableView reloadData];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
	[self.dataSourceManager removeObjectForKeyPath:[GtSlideshowOptions keyPathWithDataKey:[GtSlideshowOptions mediaItemListKey]] 
		fireDataChangedEvent:YES];

	[self.dataSourceManager setObject:[NSNumber numberWithBool:NO]
		forKeyPath:[GtSlideshowOptions keyPathWithDataKey:[GtSlideshowOptions playMusicKey]] 
		fireDataChangedEvent:YES];

	[self.navigationController popViewControllerAnimated:YES];
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) chooseMusic:(id) sender
{
	[self.navigationController setNavigationBarHidden:YES animated:YES];

	MPMediaPickerController* controller = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
	controller.delegate = self;
	controller.allowsPickingMultipleItems = YES;
//	controller.prompt = @"Choose Music for Slideshow";
	[self.navigationController pushViewController:controller animated:YES];
	GtRelease(controller);
}

- (void) addOptionsToBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection].title = NSLocalizedString(@"Options", nil);
	[builder addCell:[GtSliderValueCell sliderCell:NSLocalizedString(@"Slideshow Speed", nil) minValue:2.0 maxValue:10.0 currentValue:5.0 target:nil action:nil] forKey:[GtSlideshowOptions speedKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];

	[builder addCell:[GtOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Random Order", nil) setOn:NO target:nil action:nil] forKey:[GtSlideshowOptions randomKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];

	[builder addCell:[GtOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Repeat", nil) setOn:NO target:nil action:nil] forKey:[GtSlideshowOptions repeatKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];

//	  [builder addCell:[GtSlideshowOptions autoShowCaptionsKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];
//	  builder.cell = [GtOnOffSwitchCell onOffSwitchTableViewCell:@"Auto-Show Captions" setOn:NO target:nil action:nil]; 

	if(DeviceIsPad())
	{
		[builder addSection].title = NSLocalizedString(@"Music", nil);
		[builder addCell:[GtOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Play Music", nil) setOn:NO target:nil action:nil] forKey:[GtSlideshowOptions playMusicKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];

		[builder addCell:[GtTwoLineLabelAndValueCell twoLineLabelAndValueCell:NSLocalizedString(@"Songs", nil) value:@""] forKey:[GtSlideshowOptions mediaItemListKey] dataSourceKey:[GtSlideshowOptions dataSourceKey]];
		builder.cell.wasSelectedCallback = GtCallbackMake(self, @selector( chooseMusic:));
		builder.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		builder.cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		builder.cell.formatterClass = [GtMediaItemArrayFormatter class];
	}
}

- (void) addBeginButtonToBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addCell: [GtButtonCell buttonCell:[GtGradientButton gradientButton:GtButtonColorBrightBlue title:NSLocalizedString(@"Begin Slideshow", nil) target:self action:@selector(beginSlideshow:)] buttonMode:GtButtonCellButtonModeCenter]];
	
	[builder.cell sectionWidget].drawMode = GtTableViewCellSectionDrawModeNone;
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[self addOptionsToBuilder:builder];
	[builder addSection];
	if(m_showButton)
	{
		[self addBeginButtonToBuilder:builder];
	}
}

@end



@implementation MPMediaItemCollection (GtExtras)
+ (NSString*) displayFormatterDataToString:(MPMediaItemCollection*) collection
{
	if(!collection || !collection.count)
	{
		return NSLocalizedString(@"None", nil);
	}

//	if(collection.count == 1)
//	  {
//		return [collection.representativeItem valueForProperty:MPMediaItemPropertyTitle];
//	  }
	NSArray* items = [collection items];
	NSMutableString* str = [NSMutableString string];
	for(NSUInteger i = 0; i < items.count; i++)
	{
		[str appendFormat:(NSLocalizedString(@"%@%@ by %@", nil)), 
			i > 0 ? @", " : @"", 
			[[items objectAtIndex:i] valueForProperty:MPMediaItemPropertyTitle], 
			[[items objectAtIndex:i] valueForProperty:MPMediaItemPropertyArtist]];
	}
	
	return str;
}

@end

@implementation GtMediaItemArrayFormatter

+ (NSString*) displayFormatterDataToString:(NSArray*) items
{
	if(!items || !items.count)
	{
		return NSLocalizedString(@"None", nil);
	}

	NSMutableString* str = [NSMutableString string];
	for(NSUInteger i = 0; i < items.count; i++)
	{
		[str appendFormat:(NSLocalizedString(@"%@%@ by %@", nil)), 
			i > 0 ? @", " : @"", 
			[[items objectAtIndex:i] valueForProperty:MPMediaItemPropertyTitle], 
			[[items objectAtIndex:i] valueForProperty:MPMediaItemPropertyArtist]];
	}
	return str;
}
@end

@implementation GtSlideshowOptions (GtDisplayFormatter)

+ (NSString*) displayFormatterDataToString:(GtSlideshowOptions*) data; 
{
	NSMutableString* str = [NSMutableString stringWithFormat:(NSLocalizedString(@"Slideshow Speed: %.0f seconds", nil)), data.speedValue];
	if(data.repeatValue)
	{
		[str appendString:NSLocalizedString(@", Repeat", nil)];
	}
	if(data.randomValue)
	{
		[str appendString:NSLocalizedString(@", Random Order", nil)];
	}
	if(data.playMusicValue)
	{
		NSArray* collection = data.mediaItemList;
		if(collection && collection.count)
		{
			[str appendFormat:(NSLocalizedString(@", Play %@", nil)),
				[GtMediaItemArrayFormatter displayFormatterDataToString:collection]];
		}
	}

	return str;
}

@end
