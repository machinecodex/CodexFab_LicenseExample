//
//  CodexFab LicenseExample
//
//  XMLicensingWindowController.m
//
// Creates a pretty animating Licensing window. Modify for your own needs.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Based on MSZLinkedView by Marcus Zarra
// <http://www.cimgf.com/2008/03/03/core-animation-tutorial-wizard-dialog-with-transitions/>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.
// <http://www.machinecodex.com>


#import "XMAppDelegate.h"
#import "XMLicensingWindowController.h"
#import "XMArgumentKeys.h"

static XMLicensingWindowController *_sharedLicensingWindowController = nil;

@implementation XMLicensingWindowController

@synthesize isLicensed;
@synthesize userInfo;
@synthesize currentView;


#pragma mark -
#pragma mark Singleton

+ (XMLicensingWindowController *)sharedLicensingWindowController
{
	if (!_sharedLicensingWindowController) {
		_sharedLicensingWindowController = [[self alloc] initWithWindowNibName:[self nibName]];
	}
	return _sharedLicensingWindowController;
}

+ (NSString *)nibName {
	
	return @"Licensing";
}


#pragma mark Initialisation

- (id)initWithWindow:(NSWindow *)window {
	
	if (self = [super initWithWindow:window]) {
		
	} 
	return self;
}

-(void)dealloc {
	
	[userInfo release];
	[super dealloc];
}

- (void)awakeFromNib {
	
	NSView *contentView = [[self window] contentView];
	[contentView setWantsLayer:YES];
	[contentView addSubview:[self currentView]];
	
	transition = [CATransition animation];
	[transition setType:kCATransitionFade];
	[transition setSubtype:kCATransitionFromLeft];
	
	NSDictionary *ani = [NSDictionary dictionaryWithObject:transition forKey:@"subviews"];
	[contentView setAnimations:ani];
	
	[[self window] setLevel:NSFloatingWindowLevel];
	[[self window] setHidesOnDeactivate:YES];
	
	[self showLicensedStatus:self.isLicensed];
}


#pragma mark User interface

- (IBAction) goToWebStore:(id)sender {
		
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:kXMWebStoreURL]];
}

- (void)setCurrentView:(MSZLinkedView*)newView {
	
	if (!currentView) {
		currentView = newView;
		return;
	}
	NSView *contentView = [[self window] contentView];
	[[contentView animator] replaceSubview:currentView with:newView];
	currentView = newView;
}

- (IBAction) trial:(id)sender {
	
	// Proceed with trial...
	
	[self close:self];
}

- (IBAction) quit:(id)sender {
	
	[[NSApplication sharedApplication] terminate:self];
}

- (IBAction) registerApp:(id)sender {
	
	BOOL requestEndEditing = [[self window] makeFirstResponder:[self window]]; // Request end editing
	if (!requestEndEditing) [[self window] endEditingFor:nil];  // If request fails, force end editing
	
	// Broadcast notification of a changed registration information.
	[[NSNotificationCenter defaultCenter] postNotificationName:XMDidChangeRegistrationNotification object:self];
}

- (void) showLicensedStatus:(BOOL)status {
	
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString * regCode = [defaults valueForKey:kXMRegCode];
	NSString * name = [defaults valueForKey:kXMRegName];
	
	if (![regCode length] && ![name length]) {
		
		[self setCurrentView: viewA];
		return;
	}
	
	if (status == TRUE)
		[self setCurrentView: viewB];
	else
		[self setCurrentView:viewC];
}

- (IBAction)close:(id)sender {
	
	[[self window] orderOut:nil];
}

- (IBAction)nextView:(id)sender {
	
	if (![[self currentView] nextView]) return;
	[transition setSubtype:kCATransitionFromRight];
	[self setCurrentView:[[self currentView] nextView]];
}

- (IBAction)previousView:(id)sender {
	
	if (![[self currentView] previousView]) return;
	[transition setSubtype:kCATransitionFromLeft];
	[self setCurrentView:[[self currentView] previousView]];
}

@end

