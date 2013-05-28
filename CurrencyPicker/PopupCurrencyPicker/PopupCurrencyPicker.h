//
//  PopupCurrencyPicker.h
//
//  Created by Rajan Balana on 28/05/2013.
//  Copyright (c) 2013 Codeoi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupCurrencyPickerDelegate.h"

/// Implements a currency picker view that slides up and down
/// from the bottom of the device
///
@interface PopupCurrencyPicker : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
{
    //Parent view of Currency picker and toolbar
    UIView * _currencyView;
    UIView * _shadowView;
}
@property (strong, nonatomic) NSMutableDictionary* currencyDictionary;

@property (strong, nonatomic) NSArray *countryArray;

/// The currency pickers delegate
@property (nonatomic, assign) id delegate;

/// The currency picker view
@property (readonly) UIPickerView *currencyPicker;

/// Done selecting currency.  Causes picker to hide
@property (readonly) UIBarButtonItem *doneButton;

/// Toolbar for bar button items
@property (readonly) UIToolbar *toolbar;

/// Animation duration
@property float animationDuration;

/// Delay before animating
@property float animationDelay;

/// Show the currency picker using the specified view as the parent
///
- (void) showFromView: (UIView *) parentView;

/// Hide the currency picker
///
- (void) hide;

@end

@interface PopupCurrencyPicker (Private)

- (void) _didSelectDone;

@end
