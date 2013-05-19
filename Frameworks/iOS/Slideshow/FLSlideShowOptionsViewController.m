//
//	FLSlideShowOptionsViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/8/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSlideShowOptionsViewController.h"
#import "FLSliderValueCell.h"
#import "FLOnOffSwitchCell.h"
#import "FLButtonCell.h"
#import "FLGradientButton.h"

@interface FLMediaItemArrayFormatter : NSObject
@end

@implementation FLSlideshowOptionsViewController

@synthesize slideshowOptionsDelegate = _slideshowDelegate;

- (id) initWithSlideshowOptions:(FLSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton
{
	if((self = [super init]))
	{
		self.title = NSLocalizedString(@"Slideshow Options", nil);
		_options = FLRetain(options);
		_showButton = showStartNowButton;
	}
	return self;
}

+ (FLSlideshowOptionsViewController*) slideshowOptionsViewController:(FLSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton
{
	return FLAutorelease([[FLSlideshowOptionsViewController alloc] initWithSlideshowOptions:options showStartNowButton:showStartNowButton]);
}

- (void) dealloc
{
	FLRelease(_options);
	FLSuperDealloc();
}

- (FLSlideshowOptions*) options
{
	return _options;
}

- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager
{
	[dataSourceManager setDataSource:_options forKey:[FLSlideshowOptions dataSourceKey]];
}

- (void) beginSlideshow:(id) sender
{
	[self hideViewController:YES];
	[_slideshowDelegate slideshowOptionsViewController:self beginSlideshowWithOptions:self.options];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
	NSArray* list = FLAutorelease([mediaItemCollection.items mutableCopy]);

	[self.dataSourceManager setObject:list 
			forKeyPath:[FLSlideshowOptions keyPathWithDataKey:[FLSlideshowOptions mediaItemListKey]] 
			fireDataChangedEvent:YES];
	
	[self.dataSourceManager setObject:[NSNumber numberWithBool:mediaItemCollection.items.count >= 1] 
		forKeyPath:[FLSlideshowOptions keyPathWithDataKey:[FLSlideshowOptions playMusicKey]] 
		fireDataChangedEvent:YES];

	[self.navigationController popViewControllerAnimated:YES];
	[self.tableView reloadData];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
	[self.dataSourceManager removeObjectForKeyPath:[FLSlideshowOptions keyPathWithDataKey:[FLSlideshowOptions mediaItemListKey]] 
		fireDataChangedEvent:YES];

	[self.dataSourceManager setObject:[NSNumber numberWithBool:NO]
		forKeyPath:[FLSlideshowOptions keyPathWithDataKey:[FLSlideshowOptions playMusicKey]] 
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
	FLRelease(controller);
}

- (void) addOptionsToBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection].title = NSLocalizedString(@"Options", nil);
	[builder addCell:[FLSliderValueCell sliderCell:NSLocalizedString(@"Slideshow Speed", nil) minValue:2.0 maxValue:10.0 currentValue:5.0 target:nil action:nil] forKey:[FLSlideshowOptions speedKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];

	[builder addCell:[FLOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Random Order", nil) setOn:NO target:nil action:nil] forKey:[FLSlideshowOptions randomKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];

	[builder addCell:[FLOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Repeat", nil) setOn:NO target:nil action:nil] forKey:[FLSlideshowOptions repeatKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];

//	  [builder addCell:[FLSlideshowOptions autoShowCaptionsKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];
//	  builder.cell = [FLOnOffSwitchCell onOffSwitchTableViewCell:@"Auto-Show Captions" setOn:NO target:nil action:nil]; 

	if(DeviceIsPad())
	{
		[builder addSection].title = NSLocalizedString(@"Music", nil);
		[builder addCell:[FLOnOffSwitchCell onOffSwitchTableViewCell:NSLocalizedString(@"Play Music", nil) setOn:NO target:nil action:nil] forKey:[FLSlideshowOptions playMusicKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];

		[builder addCell:[FLTwoLineLabelAndValueCell twoLineLabelAndValueCell:NSLocalizedString(@"Songs", nil) value:@""] forKey:[FLSlideshowOptions mediaItemListKey] dataSourceKey:[FLSlideshowOptions dataSourceKey]];
		builder.cell.wasSelectedCallback = FLCallbackMake(self, @selector( chooseMusic:));
		builder.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		builder.cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		builder.cell.formatterClass = [FLMediaItemArrayFormatter class];
	}
}

- (void) addBeginButtonToBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addCell: [FLButtonCell buttonCell:[FLGradientButton gradientButton:FLGradientButtonColorBrightBlue title:NSLocalizedString(@"Begin Slideshow", nil) target:self action:@selector(beginSlideshow:)] buttonMode:FLButtonCellButtonModeCenter]];
	
	[builder.cell sectionWidget].drawMode = FLTableViewCellSectionDrawModeNone;
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
	[self addOptionsToBuilder:builder];
	[builder addSection];
	if(_showButton)
	{
		[self addBeginButtonToBuilder:builder];
	}
}

@end



@implementation MPMediaItemCollection (FLExtras)
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

@implementation FLMediaItemArrayFormatter

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

@implementation FLSlideshowOptions (FLDisplayFormatter)

+ (NSString*) displayFormatterDataToString:(FLSlideshowOptions*) data {
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
				[FLMediaItemArrayFormatter displayFormatterDataToString:collection]];
		}
	}

	return str;
}

@end
