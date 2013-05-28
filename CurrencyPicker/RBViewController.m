//
//  RBViewController.m
//  CurrencyPicker
//
//  Created by Rajan Balana on 28/05/13.
//  Copyright (c) 2013 Codeoi Apps. All rights reserved.
//

#import "RBViewController.h"
#import "PopupCurrencyPicker.h"

@interface RBViewController () <PopupCurrencyPickerDelegate>

@end

@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCurrencyPicker:(id)sender
{
    if(self.currencyPickr ==nil)
    {
        self.currencyPickr = [[PopupCurrencyPicker alloc] init];
        self.currencyPickr.delegate = self;
    }
    [self.currencyPickr showFromView:self.view];
}

#pragma popupCurrency Picker Delegate Methods

-(void)popupCurrencyPickerWillShow:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated
{
    
}

-(void)popupCurrencyPickerWillHide:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated
{
    
}

-(void)popupCurrencyPickerDidShow:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated
{
    
}

-(void)popupCurrencyPickerDidHide:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated
{
    
}
-(void)popupCurrencyPicker:(PopupCurrencyPicker *)currencyPicker didSelectCurrency:(NSArray *)currencyArray
{
    self.currencyLabel.text = [currencyArray objectAtIndex:3];
}
@end
