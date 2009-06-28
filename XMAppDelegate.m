//
//  CodexFab LicenseExample
//
// XMAppDelegate.m
//
// App delegate: substitute with your own AppDelegate or main NSDocument class.
// The important thing is to register for the XMDidChangeRegistrationNotification notification.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Based on CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.
// <http://www.machinecodex.com>


#import "XMAppDelegate.h"
#import "XMArgumentKeys.h"


@interface XMAppDelegate (Private)

- (void)registerForNotifications;

@end


@implementation XMAppDelegate

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		[self registerForNotifications];
		[self launchCheck];
	}
	
	return self;
}


#pragma mark -
#pragma mark Notification

- (void)registerForNotifications {
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationChanged:) name:XMDidChangeRegistrationNotification object:nil];	
}


@end
