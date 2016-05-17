//
//  CodexFab
//
// XMAppDelegate+Licensing.m
//
//  App delegate extension for licensing methods.
//  Pay attention to the TODO: comments below.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Designed to work with CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.


#import "XMAppDelegate.h"
#import "XMLicensingWindowController.h"
#import "XMArgumentKeys.h"
#import "CFobLicVerifier.h"


@implementation XMAppDelegate (Licensing)


- (XMLicensingWindowController *)sharedLicensingWindowController {
	
	return [XMLicensingWindowController sharedLicensingWindowController];
}

- (IBAction)showLicensingWindow:(id)sender {
		
	[[[self sharedLicensingWindowController] window] makeKeyAndOrderFront:self];
}

- (void) launchCheck {
	
	if ([self verifyLicense]) {
		
		NSLog(@"Application is registered.");
		[self sharedLicensingWindowController].isLicensed= YES;
	}
	else {
		
		NSLog(@"Application not registered.");
		[self sharedLicensingWindowController].isLicensed= NO;

		// Perform trial timeout check
	}
}

- (BOOL) verifyLicense {
		
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString * regCode = [defaults valueForKey:kXMRegCode];
	NSString * name = [defaults valueForKey:kXMRegName];
	
	// Here we match CocoaFob's licensekey.rb "productname,username" format
	NSString * regName = [NSString stringWithFormat:@"%@,%@", kXMProductCode, name];
	
	// TODO: Obfuscated public key inspired by AquaticPrime: break up your pubkey.pem and insert it below.
	// Do not use this actual key in your app: it was generated specifically for LicenseExample.app.
	// Don't insert the header or footer text, just the key itself. 
	// Add a "\n" token to represent each pubkey.pem newline.
	NSMutableString *pkb64 = [NSMutableString string];
	[pkb64 appendString:@"MIHxMIGoBgcqhkjOOAQBM"];
	[pkb64 appendString:@"IGcAkEAlkHhqwIttlb"];
	[pkb64 appendString:@"DZEK6mOY7"];
	[pkb64 appendString:@"s7EBjI/GFh"];
	[pkb64 appendString:@"hT/F7m\n4eA4vVefuIsdTm"];
	[pkb64 appendString:@"A5gBplebQ"];
	[pkb64 appendString:@"02k8JMPW"];
	[pkb64 appendString:@"aP0mV8hCDzcdIHMqrS"];
	[pkb64 appendString:@"wIVAPdSrKvB8U59\n+7I0"];
	[pkb64 appendString:@"X0wfm74v0WTzAkBwKLW3thX3IOPo4vjghDX/nHtJG3V"];
	[pkb64 appendString:@"XSmCTC7mFpv2nhXuz\nblSbboRAlMa/j0kl4vURs"];
	[pkb64 appendString:@"uVXl"];
	[pkb64 appendString:@"gvvWpCpgA0SSf0TA0QAAkEAh5RNl7/OdeCseUUY\nhn"];
	[pkb64 appendString:@"WI5rVfc7g8ZjVydDTnznSaOXBFelXJJFERjE"];
	[pkb64 appendString:@"K71bA3b"];
	[pkb64 appendString:@"zgbUHnS"];
	[pkb64 appendString:@"5P4KYBhzJO5G\n+wwciQ==\n"];
	NSString *publicKey = [NSString stringWithString:pkb64];
	
	publicKey = [CFobLicVerifier completePublicKeyPEM:publicKey];
#if (0)
	CFobLicVerifier * verifier = [CFobLicVerifier verifierWithPublicKey:publicKey];

	verifier.regName = regName;
	verifier.regCode = regCode;
	NSLog(@"publicKey %@ \n regCode: %@ regName: %@", publicKey, verifier.regCode, verifier.regName);
    
    if ([verifier verify]) {
        
        NSLog(@"Yes %@", verifier);
        return YES;
    }
#else
    
    CFobLicVerifier* verifier = [[CFobLicVerifier alloc]init];
    
    NSError* error = nil;
    [verifier setPublicKey:publicKey error:&error];
    (void)error;
    
    if ([verifier verifyRegCode:regCode forName:regName error:&error ])
    {    
        NSLog(@"Yes %@", verifier);
        [verifier release];
        return YES;
    }
    
#endif
    NSLog(@"No %@", verifier);
	
    if (verifier)
    {
        [verifier release];
    }
    
	return NO;
}
	 
- (void) registrationChanged:(NSNotification *)notification {
		
	XMLicensingWindowController * licenseWindowController = [self sharedLicensingWindowController];
	[self showLicensingWindow:self];
	
	BOOL isValidLicense = [self verifyLicense];
	
	[licenseWindowController showLicensedStatus:isValidLicense];
}

@end
