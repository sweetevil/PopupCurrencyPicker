//
//  RBViewController.h
//  CurrencyPicker
//
//  Created by Rajan Balana on 28/05/13.
//  Copyright (c) 2013 Codeoi Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopupCurrencyPicker;

@interface RBViewController : UIViewController

@property (nonatomic, strong) PopupCurrencyPicker *currencyPickr;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

- (IBAction)openCurrencyPicker:(id)sender;
@end
