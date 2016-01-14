//
//  IGRSearchViewController.m
//  exTVPlayer
//
//  Created by Vitalii Parovishnyk on 1/14/16.
//  Copyright © 2016 IGR Software. All rights reserved.
//

#import "IGRSearchViewController.h"
#import "IGRCatalogViewController.h"

@interface IGRSearchViewController () <UITextFieldDelegate>

@property (copy, nonatomic) NSString *catalogId;

@property (weak, nonatomic) IBOutlet UITextField *catalogTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation IGRSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	IGREntityAppSettings *settings = [self appSettings];
	self.catalogTextField.text = self.catalogId = settings.lastPlayedCatalog;
	self.nextButton.enabled = self.catalogId.length > 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)preferredFocusedView
{
	return self.catalogTextField;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"openCatalog"])
	{
		IGRCatalogViewController *catalogViewController = segue.destinationViewController;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[catalogViewController setCatalogId:self.catalogId];
		});
	}
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.catalogId = [textField.text copy];
	
	IGREntityAppSettings *settings = [self appSettings];
	settings.lastPlayedCatalog = self.catalogId;
	
	self.nextButton.enabled = self.catalogId.length > 0;
}

@end