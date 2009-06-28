//
//  CodexFab LicenseExample
//
//  XMLicensingWindowController.h
//
// Creates a pretty animating Licensing window. Modify for your own needs.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Uses MSZLinkedView by Marcus Zarra
// <http://www.cimgf.com/2008/03/03/core-animation-tutorial-wizard-dialog-with-transitions/>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.
// <http://www.machinecodex.com>


#import <Cocoa/Cocoa.h>
#import "MSZLinkedView.h"
#import "XMAppDelegate.h"


@interface XMLicensingWindowController : NSWindowController {
	
	IBOutlet MSZLinkedView *currentView;
	
	IBOutlet MSZLinkedView *viewA;
	IBOutlet MSZLinkedView *viewB;
	IBOutlet MSZLinkedView *viewC;

	NSMutableDictionary * userInfo;
	CATransition *transition;	
	
	BOOL isLicensed;
}

@property BOOL isLicensed;
@property (nonatomic, retain) NSMutableDictionary *userInfo;
@property (retain) MSZLinkedView *currentView;

+ (XMLicensingWindowController *)sharedLicensingWindowController;
+ (NSString *)nibName;

- (void) showLicensedStatus:(BOOL)status;

- (IBAction) goToWebStore:(id)sender;

- (IBAction)nextView:(id)sender;
- (IBAction)previousView:(id)sender;
- (IBAction)close:(id)sender;

- (IBAction) trial:(id)sender;
- (IBAction) quit:(id)sender;
- (IBAction) registerApp:(id)sender;	

@end

